#ifndef BANK_EXPENSES_H_
#define BANK_EXPENSES_H_

#include<windows.h>
#include<stdio.h>
#include<iostream>
#include<string>

using namespace std;

//Class BillHeader
class BillHeader {
private:
	string name;
	string number;
	int ProjectItem;
	int invoiceQty;
	int payOption;
	char* bank_name;
	string account;

public:
	BillHeader();  //constructor
	~BillHeader() { delete[] bank_name; } //destroyer
	
	//public function
	void ProjectItem_show() const;
	void payOption_show() const;
	int get_Qty() const { return invoiceQty; } //使用const保证不修改
	string get_account() const { return account; }
	string get_name() const { return name; }
	bool check_bill() const;
	void show_result_bil() const;

	//friend
	friend ostream& operator<<(ostream& os, const BillHeader& bil); //overloaded function to show the class

};

//class BillLines
class BillLines {
private:
	string invoiceDate;
	string amount;
	int status;
	string remark;
public:
	BillLines();
	~BillLines() {}
	bool check_lines() const; //check the information of Billlines
	void get_status() const {
		if (status == 1)
			cout << "正常";
		if (status == 2)
			cout << "丢失";
	}	//return the words
	void get_result_line() const; //Show the result
};

//get the time today
SYSTEMTIME get_time();
#endif