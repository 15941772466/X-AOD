using LuaFramework;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using XLua;

public class A_GameStart : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
       // A_LuaStart.GetInstance().DoString("require 'A_StartGame'");
        LuaHelper.GetInstance().DoString("require 'A_StartGame'");
    }
}
