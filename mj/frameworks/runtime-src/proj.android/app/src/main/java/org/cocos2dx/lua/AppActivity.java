/****************************************************************************
Copyright (c) 2008-2010 Ricardo Quesada
Copyright (c) 2010-2012 cocos2d-x.org
Copyright (c) 2011      Zynga Inc.
Copyright (c) 2013-2014 Chukong Technologies Inc.
 
http://www.cocos2d-x.org

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
****************************************************************************/
package org.cocos2dx.lua;

import org.cocos2dx.lib.Cocos2dxActivity;
import org.cocos2dx.lib.Cocos2dxGLSurfaceView;
import org.cocos2dx.platform.WeChat;
import org.cocos2dx.platform.System;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.net.wifi.WifiInfo;
import android.net.wifi.WifiManager;
import android.os.Build;
import android.os.Bundle;
import android.os.PowerManager;
import android.telephony.PhoneStateListener;
import android.telephony.SignalStrength;
import android.telephony.TelephonyManager;
import android.util.Log;
import android.view.View;


public class AppActivity extends Cocos2dxActivity{

	private Cocos2dxGLSurfaceView glSurfaceView;

	// 网络强度
	public static final int NETLEVEL_STRENGTH_NONE_OR_UNKNOWN = 0;
	public static final int NETLEVEL_STRENGTH_POOR = 1;
	public static final int NETLEVEL_STRENGTH_MODERATE = 2;
	public static final int NETLEVEL_STRENGTH_GOOD = 3;
	public static final int NETLEVEL_STRENGTH_GREAT = 4;

	private TelephonyManager tel;
	private AppPhoneStateListener appPhoneStateListener;
	public static int singnalLevel;
	public static AppActivity mContext;

	//电量
	public static int batteryValue = 0;
	BatteryBroadcastReceiver batteryBroadcastReceiver;
	IntentFilter batteryFilter;
	PowerManager.WakeLock wakeLock = null;

	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		View decorView = getWindow().getDecorView();
		// Hide both the navigation bar and the status bar.
		// SYSTEM_UI_FLAG_FULLSCREEN is only available on Android 4.1 and higher, but as
		// a general rule, you should design your app to hide the status bar whenever you
		// hide the navigation bar.
		int uiOptions = View.SYSTEM_UI_FLAG_HIDE_NAVIGATION
				| View.SYSTEM_UI_FLAG_FULLSCREEN;
		decorView.setSystemUiVisibility(uiOptions);

		//电源管理
		PowerManager pm = (PowerManager) this.getSystemService(Context.POWER_SERVICE);
		wakeLock = pm.newWakeLock(PowerManager.PARTIAL_WAKE_LOCK | PowerManager.ON_AFTER_RELEASE, "mj:PostLocationService");

		//信号强度
		appPhoneStateListener = new AppPhoneStateListener();
		tel = (TelephonyManager) getSystemService(Context.TELEPHONY_SERVICE);
		tel.listen(appPhoneStateListener, PhoneStateListener.LISTEN_SIGNAL_STRENGTHS);

		//电量监听
		batteryBroadcastReceiver = new BatteryBroadcastReceiver();
		batteryFilter = new IntentFilter(Intent.ACTION_BATTERY_CHANGED);
		registerReceiver(batteryBroadcastReceiver, batteryFilter);

		mContext = this;

		WeChat.init(this);
		System.init(this);
	}

	@Override
	public Cocos2dxGLSurfaceView onCreateView() {
		glSurfaceView = super.onCreateView();
		this.hideSystemUI();
		return glSurfaceView;
	}

	@Override
	protected void onResume() {
		super.onResume();
		tel.listen(appPhoneStateListener, PhoneStateListener.LISTEN_SIGNAL_STRENGTHS);
		registerReceiver(batteryBroadcastReceiver, batteryFilter);
	}

	@Override
	protected void onPause() {
		super.onPause();
	}

	@Override
	public void onWindowFocusChanged(boolean hasFocus)
	{
		super.onWindowFocusChanged(hasFocus);
		if (hasFocus)
		{
			this.hideSystemUI();
		}
	}

	private void hideSystemUI()
	{
		// Set the IMMERSIVE flag.
		// Set the content to appear under the system bars so that the content
		// doesn't resize when the system bars hide and show.
		glSurfaceView.setSystemUiVisibility(
				Cocos2dxGLSurfaceView.SYSTEM_UI_FLAG_LAYOUT_STABLE
						| Cocos2dxGLSurfaceView.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
						| Cocos2dxGLSurfaceView.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
						| Cocos2dxGLSurfaceView.SYSTEM_UI_FLAG_HIDE_NAVIGATION // hide nav bar
						| Cocos2dxGLSurfaceView.SYSTEM_UI_FLAG_FULLSCREEN // hide status bar
						| Cocos2dxGLSurfaceView.SYSTEM_UI_FLAG_IMMERSIVE_STICKY);
	}

	//信号强度等级
	private class AppPhoneStateListener extends PhoneStateListener {
		@Override
		public void onSignalStrengthsChanged(SignalStrength signalStrength) {
			super.onSignalStrengthsChanged(signalStrength);
			int asu = signalStrength.getGsmSignalStrength();

			if (asu <= 2 || asu == 99)
				singnalLevel = NETLEVEL_STRENGTH_NONE_OR_UNKNOWN;
			else if (asu >= 12)
				singnalLevel = NETLEVEL_STRENGTH_GREAT;
			else if (asu >= 8)
				singnalLevel = NETLEVEL_STRENGTH_GOOD;
			else if (asu >= 5)
				singnalLevel = NETLEVEL_STRENGTH_MODERATE;
			else
				singnalLevel = NETLEVEL_STRENGTH_POOR;
		}
	};

	// 获取电量信息
	public int getBatteryValue() {
		return batteryValue;
	}

	class BatteryBroadcastReceiver extends BroadcastReceiver {

		@Override
		public void onReceive(Context context, Intent intent) {
			// TODO Auto-generated method stub
			// 判断它是否是为电量变化的Broadcast Action
			if (Intent.ACTION_BATTERY_CHANGED.equals(intent.getAction())) {
				// 获取当前电量
				int level = intent.getIntExtra("level", 0);
				// 电量的总刻度
				int scale = intent.getIntExtra("scale", 100);
				// 把它转成百分比
				batteryValue = level * 100 / scale;
			}
		}
	}

	public static int getSingnalLevel(){
		return singnalLevel;
	}

	//获取Wi-Fi强度
	public static int getWifiLevel(){
		WifiManager wifiManager =(WifiManager) mContext.getApplicationContext().getSystemService(Context.WIFI_SERVICE);
		WifiInfo wifiInfo = wifiManager.getConnectionInfo();
		int wifiStrength = wifiInfo.getRssi();
		int wifiLevel = NETLEVEL_STRENGTH_NONE_OR_UNKNOWN;
		if (wifiStrength <= 0 && wifiStrength >= -50) {
			wifiLevel = NETLEVEL_STRENGTH_GREAT;
		} else if (wifiStrength < -50 && wifiStrength >= -70) {
			wifiLevel = NETLEVEL_STRENGTH_GOOD;
		} else if (wifiStrength < -70 && wifiStrength >= -80) {
			wifiLevel = NETLEVEL_STRENGTH_MODERATE;
		} else if (wifiStrength < -80 && wifiStrength >= -100) {
			wifiLevel = NETLEVEL_STRENGTH_POOR;
		}
		return wifiLevel;
	}

	// 网络类型及强度
	// netType -1: 没有网络 1: WIFI 2: 移动数据
	// netLevel 1: None 2:poor 3:moderate 4:good 5:great
	public static String getNetInfo() {
		int netType = 0;
		int netLevel = 0;
		ConnectivityManager connMgr = (ConnectivityManager) mContext
				.getSystemService(Context.CONNECTIVITY_SERVICE);
		NetworkInfo networkInfo = connMgr.getActiveNetworkInfo();
		if (null == networkInfo) {
			netType = 0;
			netLevel = 0;
		} else {
			int nType = networkInfo.getType();
			if (nType == ConnectivityManager.TYPE_MOBILE) {
				netType = 2;
			} else if (nType == ConnectivityManager.TYPE_WIFI) {
				netType = 1;
			}
			Log.d("getNetInfo", "java ---- netType --- " + netType);
			if (netType == 1) {
				netLevel = getWifiLevel();
			} else if (netType == 2) {
				netLevel = getSingnalLevel();
			} else {
				netLevel = 0;
			}
		}

		Log.d("getNetInfo", "java ---- netLevel --- " + netLevel);
		return String.format("{\"netType\":%d,\"netLevel\":%d}", netType, netLevel);
	}
}
