package com.example.dhs_schedule

import android.content.ContentResolver;
import android.content.Context;
import android.media.RingtoneManager;
import android.os.Bundle;

import java.util.TimeZone;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        MethodChannel(flutterEngine.getDartExecutor(), "colegaw.in/dhs_schedule").setMethodCallHandler(
                { call, result ->
                    if ("getTimeZoneName" == call.method) {
                        result.success(TimeZone.getDefault().getID())
                    }
                })
    }
}
