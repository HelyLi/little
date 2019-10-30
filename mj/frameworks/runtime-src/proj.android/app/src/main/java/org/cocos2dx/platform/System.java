package org.cocos2dx.platform;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.net.Uri;
import android.net.wifi.WifiInfo;
import android.net.wifi.WifiManager;
import android.provider.Settings;
import android.telephony.PhoneStateListener;
import android.telephony.SignalStrength;
import android.util.Log;
import android.widget.Toast;

import org.cocos2dx.lua.AppActivity;

import www.wan.csmj.com.R;

import static android.content.Context.WIFI_SERVICE;
//import static org.cocos2dx.lua.AppActivity.getSingnalLevel;

public class System {

    public static AppActivity mContext = null;



    public static int singnalLevel;

    public static void init(AppActivity context){
        mContext = context;
    }

    public static String getPackageName(){
        return mContext.getPackageName();
    }

    public static String getAppName(){
        return mContext.getString(R.string.app_name);
    }

    public static String getVersionName(){
        String versionName = "null";
        PackageManager pm = mContext.getPackageManager();
        PackageInfo pi;
        try {
            pi = pm.getPackageInfo(mContext.getPackageName(), PackageManager.GET_ACTIVITIES);
            if (pi != null) {
                versionName = pi.versionName == null ? "null" : pi.versionName;
            }
        } catch (PackageManager.NameNotFoundException e) {
            e.printStackTrace();
        }
        return versionName;
    }

    //进入系统GPS设置
    public static void enterGPSSetting() {
        try {
            Intent intent = new Intent(Settings.ACTION_LOCATION_SOURCE_SETTINGS);
            mContext.startActivity(intent);
        } catch (Exception e) {
            Toast.makeText(mContext, "无法打开，请手动前往设置",
                    Toast.LENGTH_SHORT).show();
        }
    }

    //进入应用GPS设置
    public static void enterAppGPSSetting() {
        Uri packageURI = Uri.parse("package:" + mContext.getPackageName());
        Intent intent =  new Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS, packageURI);

        try {
            mContext.startActivity(intent);
        } catch (Exception e) {
            Toast.makeText(mContext, "无法打开，请手动前往设置",
                    Toast.LENGTH_SHORT).show();
        }
    }

    public static int isLocationEnable(){
        return 1;
    }

    public static String getLocation(){
        return "";
    }

    public static String getShareRoomInfo(){
        return "";
    }

    public static void enterNetSetting(){

    }

    public static void exitGame(){

    }

    public static void compressImage(final String srcpath, final String dstpath, final float quality){

    }

    public static String getNetInfo(){
        return mContext.getNetInfo();
    }

    public static int getBatteryValue() {
        return mContext.getBatteryValue();
    };

    //
//    static boolean exit;
//
//    public static boolean isExit() {
//        return exit;
//    }
//
//    public static void setExit(boolean exit) {
//        System.exit = exit;
//    }
}
