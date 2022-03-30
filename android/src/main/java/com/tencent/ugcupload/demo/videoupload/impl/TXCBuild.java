package com.tencent.ugcupload.demo.videoupload.impl;

import android.os.Build;
import android.util.Log;

public class TXCBuild {
    private static final String TAG = "TXCBuild";
    private static String MODEL = "";
    private static String BRAND = "";
    private static String MANUFACTURER = "";
    private static String HARDWARE = "";
    private static String VERSION = "";
    private static int VERSION_INT = 0;
    private static String BOARD = "";
    private static String VERSION_INCREMENTAL = "";

    public TXCBuild() {
    }

    public static void SetModel(String model) {
        Class var1 = TXCBuild.class;
        synchronized(TXCBuild.class) {
            MODEL = model;
        }
    }

    public static String Model() {
        if (MODEL == null || MODEL.isEmpty()) {
            Class var0 = TXCBuild.class;
            synchronized(TXCBuild.class) {
                if (MODEL == null || MODEL.isEmpty()) {
                    MODEL = Build.MODEL;
                    Log.i("TXCBuild", "get MODEL by Build.MODEL :" + MODEL);
                }
            }
        }

        return MODEL;
    }

    public static void SetBrand(String brand) {
        Class var1 = TXCBuild.class;
        synchronized(TXCBuild.class) {
            BRAND = brand;
        }
    }

    public static String Brand() {
        if (BRAND == null || BRAND.isEmpty()) {
            Class var0 = TXCBuild.class;
            synchronized(TXCBuild.class) {
                if (BRAND == null || BRAND.isEmpty()) {
                    BRAND = Build.BRAND;
                    Log.i("TXCBuild", "get BRAND by Build.BRAND :" + BRAND);
                }
            }
        }

        return BRAND;
    }

    public static void SetManufacturer(String manufacturer) {
        Class var1 = TXCBuild.class;
        synchronized(TXCBuild.class) {
            MANUFACTURER = manufacturer;
        }
    }

    public static String Manufacturer() {
        if (MANUFACTURER == null || MANUFACTURER.isEmpty()) {
            Class var0 = TXCBuild.class;
            synchronized(TXCBuild.class) {
                if (MANUFACTURER == null || MANUFACTURER.isEmpty()) {
                    MANUFACTURER = Build.MANUFACTURER;
                    Log.i("TXCBuild", "get MANUFACTURER by Build.MANUFACTURER :" + MANUFACTURER);
                }
            }
        }

        return MANUFACTURER;
    }

    public static void SetHardware(String hardware) {
        Class var1 = TXCBuild.class;
        synchronized(TXCBuild.class) {
            HARDWARE = hardware;
        }
    }

    public static String Hardware() {
        if (HARDWARE == null || HARDWARE.isEmpty()) {
            Class var0 = TXCBuild.class;
            synchronized(TXCBuild.class) {
                if (HARDWARE == null || HARDWARE.isEmpty()) {
                    HARDWARE = Build.HARDWARE;
                    Log.i("TXCBuild", "get HARDWARE by Build.HARDWARE :" + HARDWARE);
                }
            }
        }

        return HARDWARE;
    }

    public static void SetVersion(String version) {
        Class var1 = TXCBuild.class;
        synchronized(TXCBuild.class) {
            VERSION = version;
        }
    }

    public static String Version() {
        if (VERSION == null || VERSION.isEmpty()) {
            Class var0 = TXCBuild.class;
            synchronized(TXCBuild.class) {
                if (VERSION == null || VERSION.isEmpty()) {
                    VERSION = android.os.Build.VERSION.RELEASE;
                    Log.i("TXCBuild", "get VERSION by Build.VERSION.RELEASE :" + VERSION);
                }
            }
        }

        return VERSION;
    }

    public static void SetVersionInt(int versionInt) {
        Class var1 = TXCBuild.class;
        synchronized(TXCBuild.class) {
            VERSION_INT = versionInt;
        }
    }

    public static int VersionInt() {
        if (VERSION_INT == 0) {
            Class var0 = TXCBuild.class;
            synchronized(TXCBuild.class) {
                if (VERSION_INT == 0) {
                    VERSION_INT = android.os.Build.VERSION.SDK_INT;
                    Log.i("TXCBuild", "get VERSION_INT by Build.VERSION.SDK_INT :" + VERSION_INT);
                }
            }
        }

        return VERSION_INT;
    }

    public static void SetVersionIncremental(String version_incremental) {
        Class var1 = TXCBuild.class;
        synchronized(TXCBuild.class) {
            VERSION_INCREMENTAL = version_incremental;
        }
    }

    public static String VersionIncremental() {
        if (VERSION_INCREMENTAL == null || VERSION_INCREMENTAL.isEmpty()) {
            Class var0 = TXCBuild.class;
            synchronized(TXCBuild.class) {
                if (VERSION_INCREMENTAL == null || VERSION_INCREMENTAL.isEmpty()) {
                    VERSION_INCREMENTAL = android.os.Build.VERSION.INCREMENTAL;
                    Log.i("TXCBuild", "get VERSION_INCREMENTAL by Build.VERSION.INCREMENTAL :" + VERSION_INCREMENTAL);
                }
            }
        }

        return VERSION_INCREMENTAL;
    }

    public static void SetBoard(String board) {
        Class var1 = TXCBuild.class;
        synchronized(TXCBuild.class) {
            BOARD = board;
        }
    }

    public static String Board() {
        if (BOARD == null || BOARD.isEmpty()) {
            Class var0 = TXCBuild.class;
            synchronized(TXCBuild.class) {
                if (BOARD == null || BOARD.isEmpty()) {
                    BOARD = Build.BOARD;
                    Log.i("TXCBuild", "get BOARD by Build.BOARD :" + BOARD);
                }
            }
        }

        return BOARD;
    }
}
