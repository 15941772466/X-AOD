/***
 * 
 *          定义所有UI窗体的父类。
 *           
 *           1：Display 显示状态。
 *           2：Hiding 隐藏状态
 *           3：ReDisplay 再显示状态。
 *           4：Freeze 冻结状态。

 */
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel.Design;
using UnityEngine;

namespace SUIFW
{
	public class BaseUIForm : MonoBehaviour {
        
        private UIType _CurrentUIType=new UIType();

       
        //当前UI窗体类型
	    public UIType CurrentUIType
	    {
	        get { return _CurrentUIType; }
	        set { _CurrentUIType = value; }
	    }


        #region  窗体的四种(生命周期)状态

        /// <summary>
        /// 显示状态
        /// </summary>
	    public virtual void Display()
	    {
	        this.gameObject.SetActive(true);
            //设置模态窗体调用(必须是弹出窗体)
            if (_CurrentUIType.UIForms_Type==UIFormType.PopUp)
            {
                UIMaskMgr.GetInstance().SetMaskWindow(this.gameObject);
            }
	    }

        /// <summary>
        /// 隐藏状态
        /// </summary>
	    public virtual void Hiding()
	    {
            this.gameObject.SetActive(false);
            //取消模态窗体调用
            if (_CurrentUIType.UIForms_Type == UIFormType.PopUp)
            {
                UIMaskMgr.GetInstance().CancelMaskWindow();
            }
        }

        /// <summary>
        /// 重新显示状态
        /// </summary>
	    public virtual void Redisplay()
	    {
            this.gameObject.SetActive(true);
            //设置模态窗体调用(必须是弹出窗体)
            if (_CurrentUIType.UIForms_Type == UIFormType.PopUp)
            {
                UIMaskMgr.GetInstance().SetMaskWindow(this.gameObject);
            }
        }

        /// <summary>
        /// 冻结状态
        /// </summary>
	    public virtual void Freeze()
	    {
            this.gameObject.SetActive(true);
        }


        #endregion

        #region 封装子类常用的方法

        /// <summary>
        /// 发送消息
        /// </summary>
        /// <param name="msgType">消息的类型</param>
        /// <param name="msgName">消息名称</param>
        /// <param name="msgContent">消息内容</param>
	    protected void SendMessage(string msgType,string msgName,object msgContent)
	    {
            KeyValuesUpdate kvs = new KeyValuesUpdate(msgName,msgContent);
            MessageCenter.SendMessage(msgType, kvs);	    
        }

        /// <summary>
        /// 接收消息
        /// </summary>
        /// <param name="messagType">消息分类</param>
        /// <param name="handler">消息委托</param>
	    public void ReceiveMessage(string messagType,MessageCenter.DelMessageDelivery handler)
	    {
            MessageCenter.AddMsgListener(messagType, handler);
	    }
	    #endregion

    }
}