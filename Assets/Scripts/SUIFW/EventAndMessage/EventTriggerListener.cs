/***
 * 
 *    Title: "SUIFW"UI框架项目
 *           主题： 事件触发监听      
 *    Description: 
 *           功能： 实现对于任何对象的监听处理。

 *    
 *   
 */
using UnityEngine;
using UnityEngine.EventSystems;

namespace SUIFW
{
    public class EventTriggerListener :UnityEngine.EventSystems.EventTrigger 
    {
        public delegate void VoidDelegate();
       
        public VoidDelegate onClick;
        
        //public VoidDelegate onDown;
        //public VoidDelegate onEnter;
        //public VoidDelegate onExit;
        //public VoidDelegate onUp;
        //public VoidDelegate onSelect;
        //public VoidDelegate onUpdateSelect;


        /// <summary>
        /// 得到“监听器”组件
        /// </summary>
        /// <param name="go">监听的游戏对象</param>
        /// <returns>
        /// 监听器
        /// </returns>
        public static EventTriggerListener Get(GameObject go)
        {
            EventTriggerListener lister = go.GetComponent<EventTriggerListener>();
            if (lister==null)
            {
                lister = go.AddComponent<EventTriggerListener>();                
            }
            return lister;
        }

        public override void OnPointerClick(PointerEventData eventData)
        {
            if(onClick!=null)
            {
                onClick();
            }
        }

        //public override void OnPointerDown(PointerEventData eventData)
        //{
        //    Debug.LogError("bbb");
        //    if (onDown != null)
        //    {
        //        onDown(gameObject);
        //    }
        //}

        //public override void OnPointerEnter(PointerEventData eventData)
        //{
        //    Debug.LogError("bbb");
        //    if (onEnter != null)
        //    {
        //        onEnter(gameObject);
        //    }
        //}

        //public override void OnPointerExit(PointerEventData eventData)
        //{
        //    Debug.LogError("bbb");
        //    if (onExit != null)
        //    {
        //        onExit(gameObject);
        //    }
        //}

        //public override void OnPointerUp(PointerEventData eventData)
        //{
        //    Debug.LogError("bbb");
        //    if (onUp != null)
        //    {
        //        onUp(gameObject);
        //    }
        //}
    
        //public override void OnSelect(BaseEventData eventBaseData)
        //{
        //    Debug.LogError("bbb");
        //    if (onSelect != null)
        //    {
        //        onSelect(gameObject);
        //    }
        //}

        //public override void OnUpdateSelected(BaseEventData eventBaseData)
        //{
        //    Debug.LogError("bbb");
        //    if (onUpdateSelect != null)
        //    {
        //        onUpdateSelect(gameObject);
        //    }
        //}
	
    }//Class_end
}
