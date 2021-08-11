/***
 * 
 *    Title:  测试整个框架的热更新流程。
 *                  
 *            主要功能： [主要功能]
 *          
 *    Description: 
 *            详细描述：
 *                      
 *            
 * 
 *    Date: 2019
 *    
 *    Version: 0.1
 *    
 *    Modify Recoder: 
 *   
 */
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using SUIFW;
using PFW;

namespace HotUpdateProcess
{
    public class TestHotUpdate : MonoBehaviour, IStartGame
    {
        /// <summary>
        /// 服务器更新完毕，项目开始
        /// </summary>
        public void ReceiveInfoStartRuning()
        {
            //加载登陆窗体
            UIManager.GetInstance().ShowUIForms(DemoProject.ProConst.LOGON_FROMS);
            DefenseManager.GetInstance().PreLoad();
        }
    }//Class_end
}//namespace_end