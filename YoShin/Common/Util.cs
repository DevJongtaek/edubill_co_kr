using System;
using System.Collections.Generic;
using System.Text;
using System.Windows.Forms;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Formatters.Binary;
using System.IO;
using System.Xml;
using System.Xml.Serialization;

namespace Edubill.YoShin.Common
{
    public class Util
    {
        public static object SerializeConverter(object source, Type targetDataType)
        {
            XmlSerializer vXmlSerializer = null;
            MemoryStream vTempMemoryStream = null;
            XmlDocument vTempXmlDocument = new XmlDocument();
            object vSerializedObject = null;
            try
            {
                //Serialize
                vTempMemoryStream = new MemoryStream();
                vXmlSerializer = new XmlSerializer(source.GetType());
                vXmlSerializer.Serialize(vTempMemoryStream, source);
                vTempXmlDocument.LoadXml(Encoding.UTF8.GetString(vTempMemoryStream.ToArray()));

                //Deserialize
                vTempMemoryStream = new MemoryStream();
                vXmlSerializer = new XmlSerializer(targetDataType);
                vTempXmlDocument.Save(vTempMemoryStream);

                vTempMemoryStream.Position = 0;
                vSerializedObject = (object)vXmlSerializer.Deserialize(vTempMemoryStream);

            }
            catch { }

            return vSerializedObject;
        }

        public static byte[] readFileData(string fileName)
        {
            byte[] data = null;
            FileInfo fInfo = null;

            if (!File.Exists(fileName))
                throw new FileNotFoundException("요청한 파일을 찾을 수 없습니다(" + fileName + ")");

            fInfo = new FileInfo(fileName);
            data = new byte[fInfo.Length];

            FileStream fs = fInfo.OpenRead();
            fs.Read(data, 0, (int)fInfo.Length);
            fs.Flush();
            fs.Close();

            return data;
        }

        public static bool writeFileData(string writeFileName, byte[] data)
        {
            try
            {
                // 파일이 있으면 지운다.
                if (File.Exists(writeFileName))
                    File.Delete(writeFileName);

                FileStream fs = File.OpenWrite(writeFileName);
                fs.Write(data, 0, data.Length);
                fs.Flush();
                fs.Close();

                return true;
            }
            catch
            {
                return false;
            }
        }

        public static bool writeFileData(string writeFileName, FileStream remoteStream)
        {
            byte[] buffer = new byte[1024];
            int readLength = 0,writeLength = 0;
            FileStream localStream = null;
            try
            {
                // 파일이 있으면 지운다.
                if (File.Exists(writeFileName))
                    File.Delete(writeFileName);

                localStream = new FileStream(writeFileName, FileMode.CreateNew, FileAccess.ReadWrite, FileShare.ReadWrite, 1024);

                while ((readLength = remoteStream.Read(buffer, 0, buffer.Length)) > 0)
                {
                    localStream.Write(buffer, 0, readLength);
                }
                localStream.Flush();

                return true;
            }
            catch
            {
                return false;
            }
            finally
            {
                if(remoteStream != null) remoteStream.Close();
                if (localStream != null) localStream.Close();
            }
        }

        public static DateTime convertDateTime(string yyyymmddhhnnss)
        {
            if (yyyymmddhhnnss == null || yyyymmddhhnnss.Length != 14)
                return DateTime.MinValue;

            string strTemp = "";

            strTemp += yyyymmddhhnnss.Substring(0, 4) + "/";
            strTemp += yyyymmddhhnnss.Substring(4, 2) + "/";
            strTemp += yyyymmddhhnnss.Substring(6, 2) + " ";
            strTemp += yyyymmddhhnnss.Substring(8, 2) + ":";
            strTemp += yyyymmddhhnnss.Substring(10, 2) + ":";
            strTemp += yyyymmddhhnnss.Substring(12, 2);
            return DateTime.Parse(strTemp);
        }

        public static string convertDateTime(DateTime originTime)
        {
            return originTime.ToString("yyyyMMddHHmmss");
        }
    }
}
