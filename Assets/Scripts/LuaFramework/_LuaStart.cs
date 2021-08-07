using LuaFramework;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using PFW;
public class _LuaStart : MonoBehaviour
{
    //private void OnEnable()
    //{
    //   
    //}
    void Start()
    {
        //DefenseManager.GetInstance().PreLoad();
        LuaHelper.GetInstance().DoString("require 'TestStartGame'");
    }

}
