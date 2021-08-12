using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace SUIFW
{
	public class UnityHelper : MonoBehaviour {
        
	    public static Transform FindTheChildNode(GameObject goParent,string childName)     // 查找子节点对象
        {
            Transform searchTrans = null;                   //查找结果
            searchTrans=goParent.transform.Find(childName);
            if (searchTrans==null)
            {
                foreach (Transform trans in goParent.transform)
                {
                    searchTrans=FindTheChildNode(trans.gameObject, childName);
                    if (searchTrans!=null)
                    {
                        return searchTrans;
                    }
                }            
            }
            return searchTrans;
        }

        /// <summary>
        /// 给子节点添加父对象
        /// </summary>
        /// <param name="parents">父对象的方位</param>
        /// <param name="child">子对象的方法</param>
	    public static void AddChildNodeToParentNode(Transform parents, Transform child)
	    {
            child.SetParent(parents,false);
	        child.localPosition = Vector3.zero;
	        child.localScale = Vector3.one;
	        child.localEulerAngles = Vector3.zero;
	    }
	}
}