using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;

/// <summary>
/// ExceptionWriter의 요약 설명입니다.
/// </summary>
public class ExceptionWriter
{
    public ExceptionWriter()
    {
        //
        // TODO: 여기에 생성자 논리를 추가합니다.
        //
    }
    public void SendException(SerializableException E, User value)
    {
        XmlSerializer serializer = new XmlSerializer(typeof(WrapException));
        WrapException o = new WrapException { E = E, SendUser = value };
        string filePath = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.CommonApplicationData),
            "ExceptionReciever/ExceptionLog");
        filePath = Path.Combine(filePath,
           string.Format("{0}.xml", DateTime.Now.ToString("yyyyMMddhhmmss")));
        StreamWriter writer = new StreamWriter(filePath);
        serializer.Serialize(writer, o);
        writer.Close();
        writer.Dispose();
    }
}
public class WrapException
{
    public WrapException()
    { }
    [XmlElement]
    public SerializableException E { get; set; }
    [XmlElement]
    public User SendUser { get; set; }
}
public class SerializableException
{
    [XmlElement]
    public string Message { get; set; }

    [XmlElement]
    public string Source { get; set; }

    [XmlElement]
    public string StackTrace { get; set; }

    [XmlElement]
    public string InnerExceptionName { get; set; }

    [XmlElement]
    public string InnerExceptionMessage { get; set; }
}
