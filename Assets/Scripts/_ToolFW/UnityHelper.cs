using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace TFW
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
	}
}