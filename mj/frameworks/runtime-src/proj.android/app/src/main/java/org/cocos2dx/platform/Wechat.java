package org.cocos2dx.platform;

import android.app.Activity;

public class Wechat {

    public static Activity mContext;
    public static IWXAPI wxapi;

    public static void init(Activity activity){
        mContext = activity;
    }

    public static void initAppId(String appId){
        wxapi = WXAPIFactory.createWXAPI(mContext,appId, true);
        wxapi.registerApp(appId);
    }

    public static int isInstalled(String appId){

    }



}
