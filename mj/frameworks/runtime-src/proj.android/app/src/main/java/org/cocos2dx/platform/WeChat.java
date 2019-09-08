package org.cocos2dx.platform;

import android.app.Activity;
import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.util.DisplayMetrics;

import com.tencent.mm.opensdk.modelmsg.SendAuth;
import com.tencent.mm.opensdk.modelmsg.SendMessageToWX;
import com.tencent.mm.opensdk.modelmsg.WXImageObject;
import com.tencent.mm.opensdk.modelmsg.WXMediaMessage;
import com.tencent.mm.opensdk.modelmsg.WXTextObject;
import com.tencent.mm.opensdk.modelmsg.WXWebpageObject;
import com.tencent.mm.opensdk.openapi.IWXAPI;
import com.tencent.mm.opensdk.openapi.WXAPIFactory;

import org.cocos2dx.lib.Cocos2dxLuaJavaBridge;
import org.json.JSONException;
import org.json.JSONObject;

import www.wan.csmj.com.R;

public class WeChat {

    public static Activity mContext;
    public static int mHandlerID = -1;
    public static String mAppId = "";
    public static IWXAPI wxapi;
    public static int circle = 0;

    public static void init(Activity activity){
        mContext = activity;
    }

    public static void initAppId(String appId){
        wxapi = WXAPIFactory.createWXAPI(mContext, appId, true);
        wxapi.registerApp(appId);
    }

    public static int isInstalled(String appId){
        WeChat.initAppId(appId);
        if (wxapi.isWXAppInstalled()){
            return 1;
        }
        return 0;
    }

    public static void openApp(String appId){
        WeChat.initAppId(appId);
        wxapi.openWXApp();
    }

    public static void doLoginReq(final String appId,final int handlerId){
        mAppId = appId;
        mHandlerID = handlerId;
        mContext.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                if (WeChat.isInstalled(appId) == 0){
                    return;
                }
                final SendAuth.Req req = new SendAuth.Req();
                req.scope = "snsapi_userinfo";
                req.state = "weichat_sdk";
                wxapi.sendReq(req);
                wxapi.unregisterApp();
            }
        });
    }

    public static void callbackLua(final String code){
        mContext.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                if (mHandlerID > 0){
                    String ret = "";
                    try {
                        JSONObject retstr = new JSONObject();
                        retstr.put("status", 0);
                        retstr.put("code", code);
                        retstr.put("circle", circle);
                        ret = retstr.toString();
                    }catch (JSONException e){
                        e.printStackTrace();
                    }

                    Cocos2dxLuaJavaBridge.callLuaFunctionWithString(mHandlerID, ret);
                    Cocos2dxLuaJavaBridge.releaseLuaFunction(mHandlerID);
                    mHandlerID = -1;
                }
            }
        });
    }

    public static void doShare(final String appId,
                             final String title,
                             final String des,
                             final String url,
                             final String path,
                             final int isCircle,
                             final int isImg,
                             final int isTxt,
                             final int handlerId){
        mAppId = appId;
        mHandlerID = handlerId;
        mContext.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                WXMediaMessage msg = new WXMediaMessage();
                WeChat.initAppId(mAppId);
                if (isTxt > 0){
                    WXTextObject obj = new WXTextObject();
                    obj.text = des;
                    msg.mediaObject = obj;
                    msg.description = des;
                }else if (isImg > 0){
                    Resources resources = mContext.getResources();
                    DisplayMetrics dm = resources.getDisplayMetrics();

                    int widthPixel = dm.widthPixels;
                    int heightPixel = dm.heightPixels;

                    if(dm.widthPixels < dm.heightPixels){
                        widthPixel = dm.heightPixels;
                        heightPixel = dm.widthPixels;
                    }

                    float destWidth = 800;
                    float destHeight = (float)heightPixel * ( (float)800 / (float)dm.widthPixels);

                    Bitmap srcBitmap = BitmapFactory.decodeFile(path);
                    if (srcBitmap == null) {
                        return;
                    }
                    Bitmap destBitmap = Bitmap.createScaledBitmap(srcBitmap, (int) destWidth, (int) destHeight, true);
                    if (isImg == 2) {
                        destBitmap = srcBitmap;
                    }

                    WXImageObject img = new WXImageObject(destBitmap);

                    msg = new WXMediaMessage(img);
                    msg.title = title;
                    msg.description = des;

                    Bitmap thumbBmp = Bitmap.createScaledBitmap(srcBitmap, 200, 112,
                            true);
                    srcBitmap.recycle();
                    destBitmap.recycle();
                    msg.setThumbImage(thumbBmp);

                }else {
                    WXWebpageObject web = new WXWebpageObject();
                    web.webpageUrl = url;
                    msg = new WXMediaMessage(web);

                    msg.title = title;
                    msg.description = des;
                    Bitmap thumb = BitmapFactory.decodeResource(mContext.getResources(), R.drawable.icon);
                    Bitmap thumbBmp = drawBg4Bitmap(Color.WHITE, thumb);

                    thumb.recycle();

                    msg.setThumbImage(thumbBmp);
                }

                SendMessageToWX.Req req = new SendMessageToWX.Req();
                req.transaction = String.valueOf(java.lang.System.currentTimeMillis());
                req.message = msg;
                if (isCircle > 0) {
                    req.scene = SendMessageToWX.Req.WXSceneTimeline;
                    circle = 1;
                } else {
                    req.scene = SendMessageToWX.Req.WXSceneSession;
                    circle = 0;
                }
                wxapi.sendReq(req);
            }
        });
    }

    public static Bitmap drawBg4Bitmap(int color, Bitmap orginBitmap) {
        Paint paint = new Paint();
        paint.setColor(color);
        Bitmap bitmap = Bitmap.createBitmap(orginBitmap.getWidth(),
                orginBitmap.getHeight(), orginBitmap.getConfig());
        Canvas canvas = new Canvas(bitmap);
        canvas.drawRect(0, 0, orginBitmap.getWidth(), orginBitmap.getHeight(), paint);
        canvas.drawBitmap(orginBitmap, 0, 0, paint);
        return bitmap;
    }
}
