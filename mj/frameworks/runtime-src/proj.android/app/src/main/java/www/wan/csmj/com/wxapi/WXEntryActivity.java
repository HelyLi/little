package www.wan.csmj.com.wxapi;


import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;

import com.tencent.mm.opensdk.constants.ConstantsAPI;
import com.tencent.mm.opensdk.modelbase.BaseReq;
import com.tencent.mm.opensdk.modelbase.BaseResp;
import com.tencent.mm.opensdk.modelmsg.SendAuth;
import com.tencent.mm.opensdk.openapi.IWXAPI;
import com.tencent.mm.opensdk.openapi.IWXAPIEventHandler;
import com.tencent.mm.opensdk.openapi.WXAPIFactory;

import org.cocos2dx.platform.WeChat;

public class WXEntryActivity extends Activity implements IWXAPIEventHandler {

    private IWXAPI iwxapi;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        iwxapi = WXAPIFactory.createWXAPI(this, WeChat.mAppId);
        try {
            iwxapi.handleIntent(getIntent(), this);
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    @Override
    public void onReq(BaseReq baseReq) {

    }

    @Override
    public void onResp(BaseResp baseResp) {
        switch (baseResp.errCode){
            case BaseResp.ErrCode.ERR_OK:
                if (baseResp.getType() == ConstantsAPI.COMMAND_SENDAUTH){
                    SendAuth.Resp resp = ((SendAuth.Resp) baseResp);
                    String code = resp.code;
                    WeChat.callbackLua(code);
                }else if(baseResp.getType() == ConstantsAPI.COMMAND_SENDMESSAGE_TO_WX){
                    WeChat.callbackLua(String.valueOf(baseResp.errCode));
                }
                break;
            case BaseResp.ErrCode.ERR_USER_CANCEL:
            case BaseResp.ErrCode.ERR_AUTH_DENIED:
            default:
                WeChat.callbackLua(String.valueOf(baseResp.errCode));
                    break;
        }
        finish();
    }

    @Override
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        setIntent(intent);
        iwxapi.handleIntent(intent, this);
    }

}
