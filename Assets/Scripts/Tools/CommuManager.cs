using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
namespace Communication
{
    public  class CommuManager
    {
        //本类静态实例
        private static CommuManager _Instance;
        public string cur_name ="a";
        public string cur_content = "a";
        string showContent = " ";

        public static CommuManager GetInstance()
        {
            if (_Instance == null)
            {
                _Instance = new CommuManager();
            }
            return _Instance;
        }
        public void SendMes(string content)
        {
            cur_name = "b";
            cur_content = content;
            Debug.Log("sssssssssssss");
            //服务器操作
            //...

            //闭环  聊天室输出
           Show(cur_name, cur_content);
        }

        public string Show(string aname, string content)
        {
            showContent = showContent+ "\n" + aname + ": " + content;
            Debug.Log("showContent: "+ showContent);
            return showContent;
        }
        public string ShowText()
        {
            Debug.Log("showContent: " + showContent);
            return showContent;
        }
    }
}

