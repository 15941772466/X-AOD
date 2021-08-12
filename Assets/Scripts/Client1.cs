using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Net.Sockets;
using System.Net;
using Google.Protobuf;
using Network;

public class Client1 : MonoBehaviour
{
    //连接
    static Socket send = new Socket(AddressFamily.InterNetwork,SocketType.Stream,ProtocolType.Tcp);
    static Socket receive = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
    static Socket connect = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
    static Communication.CommuManager commuManager = new Communication.CommuManager();
    //接收消息
    public static void ReceiveMessage()
    {
        //1111接收端口
        IPEndPoint endPoint = new IPEndPoint(GetIPV4(), 1111);
        Socket socket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
        socket.Bind(endPoint);
        socket.Listen(1);
        receive = socket.Accept();
        Message message1 = new Message();
        byte[] data = new byte[message1.CalculateSize()];
        ////第一次握手，接收到数据确认链接成功
        using (CodedInputStream inputStream = new CodedInputStream(data))
        {
            message1.MergeFrom(inputStream);
        }
        receive.Receive(data, 0, data.Length, SocketFlags.Partial);
        //ShowMessage(message1.MyName, message1.MyMessage);//简单替代
        commuManager.Show(message1.MyName, message1.MyMessage);
        //从客户端接收消息
        //显示消息
    }
    //发送消息
    //public void SendMessage(string name,string message)
    //{
    //    //2222发送端口
    //    //send.Connect(ConnectRequest(), 1111);
    //    Message message1 = new Message();
    //    message1.MyMessage = message;
    //    send.Send(message1.ToByteArray());
    //    //将消息发送到服务器
    //}
    public static void SendMessage(string name, string message)
    {
        Message tmpmessage = new Message();
        tmpmessage.MyMessage = message;
        tmpmessage.MyName = name;
        if (!send.Connected)
        {
            send.Connect("10.0.11.202", 33678);//服务器监听端口
        }

        send.Send(tmpmessage.ToByteArray());
        //byte[] data = new byte[tmpmessage.CalculateSize()];
        //////第一次握手，接收到数据确认链接成功
        //using (CodedInputStream inputStream = new CodedInputStream(data))
        //{
        //    tmpmessage.MergeFrom(inputStream);
        //}
        //connect.Receive(data, 0, data.Length, SocketFlags.Partial);
    }
    public static IPAddress GetIPV4()
    {
        //获取主机名
        string name = Dns.GetHostName();
        //ip地址集合
        IPAddress[] ipadrlist = Dns.GetHostAddresses(name);
        //寻找IPV4
        foreach (IPAddress ipa in ipadrlist)
        {
            if (ipa.AddressFamily == AddressFamily.InterNetwork)
            return ipa;
        }
        return null;
    }

    private void ShowMessage(string name,string message)
    {

    }

    public static void SendLoginInfo(string name,IPAddress ip)
    {
        Message tmpmessage = new Message();
        tmpmessage.MyIp = ip.ToString();
        tmpmessage.MyName = name;
        print("被调用了here");
        connect.Connect("10.0.11.202", 33666);//服务器监听端口
        connect.Send(tmpmessage.ToByteArray());
        print(connect.Connected);
        print("被调用了");
    }
}
