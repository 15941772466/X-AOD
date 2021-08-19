using LuaFramework;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using XLua;

public class A_GameStart : MonoBehaviour
{
    public GameObject StartTipUI;
    // Start is called before the first frame update
    void Start()
    {
        StartCoroutine("StartTip");
        // A_LuaStart.GetInstance().DoString("require 'A_StartGame'");
        Invoke("Game_start", 6.5f);
    }

    void Game_start()
    {
        LuaHelper.GetInstance().DoString("require 'A_StartGame'");
        StartTipUI.SetActive(false);
    }

    IEnumerator StartTip()
    {
        yield return new WaitForSeconds(1f);
        StartTipUI.SetActive(true);
    }
}
