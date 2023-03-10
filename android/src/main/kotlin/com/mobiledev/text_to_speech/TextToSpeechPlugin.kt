package com.mobiledev.text_to_speech

import android.app.Activity
import android.speech.tts.TextToSpeech
import android.speech.tts.TextToSpeech.OnInitListener
import android.speech.tts.Voice
import android.util.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.util.*

class TextToSpeechPlugin : FlutterPlugin, MethodChannel.MethodCallHandler, ActivityAware,
    OnInitListener {
    private lateinit var channel: MethodChannel
    private var activity: Activity? = null
    private var tts: TextToSpeech? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(binding.binaryMessenger, "text_to_speech")
        channel.setMethodCallHandler(this)
        tts = TextToSpeech(binding.applicationContext, this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "set_pitch" ->
                tts!!.setPitch((call.arguments as Double).toFloat())

            "set_rate" ->
                tts!!.setSpeechRate((call.arguments as Double).toFloat())

            "set_voice" -> setVoice(call.arguments as Boolean)
            "speak" -> speak(call)
            else -> result.notImplemented()
        }
    }


    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        this.activity = binding.activity
    }


    override fun onDetachedFromActivityForConfigChanges() {
        print("onDetachedFromActivityForConfigChanges")
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        print("onReattachedToActivityForConfigChanges")
    }

    override fun onDetachedFromActivity() {
        print("onDetachedFromActivity")
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)

    }

    override fun onInit(status: Int) {
        if (status == TextToSpeech.SUCCESS) {
            val voice = Voice("en-us-x-iom-local", Locale.US, 400, 200, false, null)
            tts!!.voice = voice
            val result = tts!!.setLanguage(Locale.US)

            if (result == TextToSpeech.LANG_MISSING_DATA || result == TextToSpeech.LANG_NOT_SUPPORTED) {
                Log.e("TTS", "The Language specified is not supported!")
            }

        } else {
            Log.e("TTS", "Initilization Failed!")
        }
    }

    private fun setVoice(male: Boolean) {
        val name = if (male) "en-us-x-iom-local" else "en-us-x-tpf-local"
        val voice = Voice(name, Locale.US, 400, 200, false, null)
        tts!!.voice = voice
    }

    private fun speak(call: MethodCall) {
        tts!!.speak(call.arguments as String, TextToSpeech.QUEUE_FLUSH, null, "")
    }
}