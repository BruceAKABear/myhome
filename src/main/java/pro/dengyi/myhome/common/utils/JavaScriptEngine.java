package pro.dengyi.myhome.common.utils;

import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;

public class JavaScriptEngine {

    public static ScriptEngine engine;

    static {
        ScriptEngineManager mgr = new ScriptEngineManager();
        engine = mgr.getEngineByName("JavaScript");
    }
}