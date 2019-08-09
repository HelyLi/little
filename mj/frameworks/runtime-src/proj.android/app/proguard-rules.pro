# Add project specific ProGuard rules here.
# By default, the flags in this file are appended to flags specified
# in /Users/u0u0/bin/adt-bundle-mac/sdk/tools/proguard/proguard-android.txt
# You can edit the include path and order by changing the proguardFiles
# directive in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# Add any project specific keep options here:

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile




#############################################
#
# 对于一些基本指令的添加
#
#############################################
# 代码混淆压缩比，在0~7之间，默认为5，一般不做修改
-optimizationpasses 5

# 混合时不使用大小写混合，混合后的类名为小写
-dontusemixedcaseclassnames

# 指定不去忽略非公共库的类
-dontskipnonpubliclibraryclasses

# 这句话能够使我们的项目混淆后产生映射文件
# 包含有类名->混淆后类名的映射关系
-verbose

# 指定不去忽略非公共库的类成员
-dontskipnonpubliclibraryclassmembers

# 不做预校验，preverify是proguard的四个步骤之一，Android不需要preverify，去掉这一步能够加快混淆速度。
-dontpreverify

# 保留Annotation不混淆
-keepattributes *Annotation*,InnerClasses

# 避免混淆泛型
-keepattributes Signature

# 抛出异常时保留代码行号
-keepattributes SourceFile,LineNumberTable

# 指定混淆是采用的算法，后面的参数是一个过滤器
# 这个过滤器是谷歌推荐的算法，一般不做更改
-optimizations !code/simplification/cast,!field/*,!class/merging/*

-ignorewarnings -keep class * { public private *; }
#############################################
#
# Android开发中一些需要保留的公共部分
#
#############################################

# 保留我们使用的四大组件，自定义的Application等等这些类不被混淆
# 因为这些子类都有可能被外部调用
-keep public class * extends android.app.Activity
-keep public class * extends android.app.Appliction
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider
-keep public class * extends android.app.backup.BackupAgentHelper
-keep public class * extends android.preference.Preference
-keep public class * extends android.view.View
-keep public class * extends android.view.ViewGroup
-keep public class com.android.vending.licensing.ILicensingService


# 保留support下的所有类及其内部类
-dontnote android.support.**
-dontnote androidx.**
-dontwarn android.support.**
-dontwarn androidx.**
-keep class android.support.** {*;}

# 保留继承的
-keep public class * extends android.support.v4.**
-keep public class * extends android.support.v7.**
-keep public class * extends android.support.annotation.**

# 保留R下面的资源
-keep class **.R$* {*;}

# 保留本地native方法不被混淆
-keepclasseswithmembernames class * {
    native <methods>;
}

# 保留在Activity中的方法参数是view的方法，
# 这样以来我们在layout中写的onClick就不会被影响
-keepclassmembers class * extends android.app.Activity{
    public void *(android.view.View);
}

# 保留枚举类不被混淆
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# 保留我们自定义控件（继承自View）不被混淆
-keep public class * extends android.view.View{
    *** get*();
    void set*(***);
    public <init>(android.content.Context);
    public <init>(android.content.Context, android.util.AttributeSet);
    public <init>(android.content.Context, android.util.AttributeSet, int);
}

# 保留Parcelable序列化类不被混淆
-keep class * implements android.os.Parcelable {
    public static final android.os.Parcelable$Creator *;
}

# 保留Serializable序列化的类不被混淆
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    !static !transient <fields>;
    !private <fields>;
    !private <methods>;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}

# 对于带有回调函数的onXXEvent、**On*Listener的，不能被混淆
-keepclassmembers class * {
    void *(**On*Event);
    void *(**On*Listener);
}

# webView处理，项目中没有使用到webView忽略即可
-keepclassmembers class fqcn.of.javascript.interface.for.webview {
    public *;
}
-keepclassmembers class * extends android.webkit.webViewClient {
    public void *(android.webkit.WebView, java.lang.String, android.graphics.Bitmap);
    public boolean *(android.webkit.WebView, java.lang.String);
}
-keepclassmembers class * extends android.webkit.webViewClient {
    public void *(android.webkit.webView, jav.lang.String);
}

# 移除Log类打印各个等级日志的代码，打正式包的时候可以做为禁log使用，这里可以作为禁止log打印的功能使用
# 记得proguard-android.txt中一定不要加-dontoptimize才起作用
# 另外的一种实现方案是通过BuildConfig.DEBUG的变量来控制
#-assumenosideeffects class android.util.Log {
#    public static int v(...);
#    public static int i(...);
#    public static int w(...);
#    public static int d(...);
#    public static int e(...);
#}

#############################################
#
# 项目中特殊处理部分
#
#############################################

#-----------处理反射类---------------



#-----------处理js交互---------------



#-----------处理实体类---------------
# 在开发的时候我们可以将所有的实体类放在一个包内，这样我们写一次混淆就行了。
-keep class com.hhly.partner.data.net.protocol.** {*;}


#-----------处理第三方依赖库---------

# ----  rxbinding start  ----
# ----  rxbinding end  ----

# ----  rxjava  rxandroid start  ----
-dontwarn sun.misc.**
-keepclassmembers class rx.internal.util.unsafe.*ArrayQueue*Field* {
    long producerIndex;
    long consumerIndex;
}
-keepclassmembers class rx.internal.util.unsafe.BaseLinkedQueueProducerNodeRef {
    rx.internal.util.atomic.LinkedQueueNode producerNode;
}
-keepclassmembers class rx.internal.util.unsafe.BaseLinkedQueueConsumerNodeRef {
    rx.internal.util.atomic.LinkedQueueNode consumerNode;
}
# ----  rxjava  rxandroid end  ----

#  ----retrofit2 的混淆代码 start  ----
-dontwarn retrofit2.**
-keep class retrofit2.** { *; }
-keepattributes Signature
-keepattributes Exceptions
#  ----retrofit2 的混淆代码 end  ----

#  ----Gson 的混淆代码 start  ----
-keepattributes *Annotation*
-keep class sun.misc.Unsafe { *; }
-keep class com.google.gson.stream.** { *; }
# 使用Gson时需要配置Gson的解析对象及变量都不混淆。不然Gson会找不到变量。
# 将下面替换成自己的实体类 实体类前面有保存
#-keep class com.example.bean.** { *; }
#  ----Gson 的混淆代码 end  ----

#  ----okhttp3 的混淆代码 start  ----
-dontwarn com.squareup.okhttp3.**
-keep class com.squareup.okhttp3.** { *;}
-dontwarn okio.**
#  ----okhttp 的混淆代码 end  ----

#  ----okio 的混淆代码 start  ----
-dontwarn com.squareup.**
-dontwarn okio.**
-keep public class org.codehaus.* { *; }
-keep public class java.nio.* { *; }
#  ----okio 的混淆代码 end  ----

#  ----rxlifecycle 的混淆代码 start  ----
#  ----rxlifecycle 的混淆代码 end  ----


#  ----glide 的混淆代码 start  ----
-keep public class * implements com.bumptech.glide.module.GlideModule
-keep public enum com.bumptech.glide.load.resource.bitmap.ImageHeaderParser$** {
  **[] $VALUES;
  public *;
}
#  ----glide 的混淆代码 end  ----

#  ----logger 的混淆代码 start  ----
#  ----logger 的混淆代码 end  ----

#  ----butterknife 的混淆代码 start  ----
-keep class butterknife.** { *; }
-dontwarn butterknife.internal.**
-keep class **$$ViewBinder { *; }
-keepclasseswithmembernames class * {
    @butterknife.* <fields>;
}
-keepclasseswithmembernames class * {
    @butterknife.* <methods>;
}
#  ----butterknife 的混淆代码 end  ----

# ----  baseRecyclerViewHelper start  ----
-keep class com.chad.library.adapter.** {
   *;
}
# ----  baseRecyclerViewHelper end  ----

# ----  MPAndroidChart start  ----
-keep class com.github.mikephil.charting.** { *; }     # 确保MPAndroidChart加载动画可用
# ----  MPAndroidChart end  ----

# ----  flowlayout start  ----
# ----  flowlayout end  ----

# ----  zxing start  ----
# ----  zxing end  ----

# ----  NestFullListView start  ----
# ----  NestFullListView end  ----


# ----  greendao start  ----
#-keepclassmembers class * extends org.greenrobot.greendao.AbstractDao {
#public static java.lang.String TABLENAME;
#           }
#-keep class **$Properties

# If you do not use SQLCipher:
#-dontwarn org.greenrobot.greendao.database.**
# If you do not use RxJava:
#-dontwarn rx.**
# ----  greendao end  ----

# ----  QQ start  ----
-dontwarn com.tencent.**
-keepattributes InnerClasses
#-keep class * extends android.app.Dialog
# ----  QQ end  ----

# ----  Wechat start  ----
#-keep class com.tencent.mm.opensdk.** {
#   *;
#}
#-keep class com.tencent.wxop.** {
#   *;
#}
#-keep class com.tencent.mm.sdk.** {
#   *;
#}
# ----  Wechat end  ----

# ----  sina start  ----

# ----  sina end  ----