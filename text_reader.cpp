#include <iostream>
#include <string>
#include <codecvt>
#include <fstream>
using namespace std;
int main() 
{

    //ԭʼ��UTF-8�ı������in.txt��
    ifstream infile("in.txt");

    //�����˵������ŵ��ı����´��뵽out.txt��
    ofstream outfile("out.txt");

    int count = 0;

    //����ļ��Ƿ��
    if (!infile) {
        cout << "Can not open file in.txt" << endl;
        return -1;
    }
    if (!outfile) {
        cout << "Can not open file out.txt" << endl;
        return -1;
    }

    //����ת������
    wstring_convert<codecvt_utf8<wchar_t>> conv;

    //���ж�ȡ�ļ�
    while (!infile.eof()) 
    {
        string s;
        getline(infile, s);

        //ת���ɿ��ֽ�����
        wstring ws = conv.from_bytes(s);
        wstring nws;
        //����ÿһ���еı��Ϳո�

        for (wchar_t ch : ws) 
        {
            //����Ƿ��Ǳ��Ϳո�
            if (!iswpunct(ch) && !iswspace(ch)) 
            {
                count++;
                if (count == 20)
                {
                    outfile << std::endl;
                }
                string ns = conv.to_bytes(ch);
                outfile << ns;
                
            }
        }
   
    }
    //�ر��ļ�
    infile.close();
    outfile.close();
    return 0;
}