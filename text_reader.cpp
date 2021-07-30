#include <iostream>
#include <string>
#include <codecvt>
#include <fstream>
using namespace std;
int main() 
{

    //原始的UTF-8文本存放在in.txt中
    ifstream infile("in.txt");

    //将过滤掉标点符号的文本重新存入到out.txt中
    ofstream outfile("out.txt");

    int count = 0;

    //检查文件是否打开
    if (!infile) {
        cout << "Can not open file in.txt" << endl;
        return -1;
    }
    if (!outfile) {
        cout << "Can not open file out.txt" << endl;
        return -1;
    }

    //定义转换对象
    wstring_convert<codecvt_utf8<wchar_t>> conv;

    //按行读取文件
    while (!infile.eof()) 
    {
        string s;
        getline(infile, s);

        //转换成宽字节类型
        wstring ws = conv.from_bytes(s);
        wstring nws;
        //过滤每一行中的标点和空格

        for (wchar_t ch : ws) 
        {
            //检查是否是标点和空格
            if (!iswpunct(ch) && !iswspace(ch)) 
            {
                count++;
                if (count == 20)
                {
                    outfile << std::endl;
                    count = 1;
                }
                string ns = conv.to_bytes(ch);
                outfile << ns;
                
            }
        }
   
    }
    //关闭文件
    infile.close();
    outfile.close();
    return 0;
}
