#include"Bank_expense.h"

using std::cout;
using std::endl;
using std::cin;

int check_fal = 0;

BillHeader::BillHeader()
{
	cout << "Pleasen enter your number (8 numbers): ";
	getline(cin, number);
	cout  << "Please enter your name: ";
	getline(cin, name);
	cout << "Please choose your Item, 1 for house-moving, 2 for phisical examination: ";
	cin >> ProjectItem;
	cin.get();
	cout << "Please enter the number of Qty: ";
	cin >> invoiceQty;
	cin.get();
	cout << "Please choose your pay-option, 1 for cash, 2 for trans: ";
	cin >> payOption;
	
	if (payOption == 2)
	{
		cout << "Please enter the name of the bank: ";
		bank_name = new char[20];
		cin.get();
		cin.get(bank_name, 20).get();

		cout << "Then please enter your account(16 numbers, start with 62): ";
		getline(cin, account);
	}
	else
	{
		bank_name = new char[20]; 
		strcpy_s(bank_name, 10, "Null");
		cin.get();
		account = "null";
	}
}

void BillHeader::ProjectItem_show() const
{
	if (ProjectItem == 1)
		cout << "Ìå¼ì·ÑÓÃ";
	if (ProjectItem == 2)
		cout << "°á¼Ò·ÑÓÃ";
}

void BillHeader::payOption_show() const
{
	if (payOption == 1)
		cout << "ÏÖ½ð";
	if (payOption == 2)
		cout << "ÒøÐÐ×ªÕË";
}

bool BillHeader::check_bill() const
{
	if (name.size() == 0)
	{
		cout << "Ê§°Ü\nmessage: You have not input name yet.\n";
		check_fal++;
		return 0;
	}
	else if (number.size() != 8)
	{
		if (check_fal == 0)
		{
			cout << "Ê§°Ü\nmessage: wrong number, please enter 8 numbers\n";
			check_fal++;
		}
		else
		{
			cout << "\nmessage: wrong number. please enter 8 numbers\n";
		}
		return 0;
	}
	else if ((ProjectItem != 1) && (ProjectItem != 2))
	{
		if (check_fal == 0)
		{
			cout << "Ê§°Ü\nmessage: wrong projectItem.\n";
			check_fal++;
		}
		else
			cout << "\nmessage: wrong projectItem.\n";
		return 0;
	}
	else if ((payOption != 1) && (payOption != 2))
	{
		if (check_fal == 0)
		{
			cout << "Ê§°Ü\nmessage: wrong payOption.\n";
			check_fal++;
		}
		else 
			cout << "\nmessage: wrong payOption.\n";
		return 0;
	}

	if ((account.size() != 16) || (account[0] != '6') || (account[1] != '2'))
	{
		if (check_fal == 0)
		{
			cout << "Ê§°Ü\nmessage: Wrong account number.\n";
			check_fal++;
		}
		else
			cout << "\nmessage: Wrong account number.\n";
		return 0;
	}

	return 1;
}


void BillHeader::show_result_bil() const
{
	cout << "BillHeader: {\n" << "number: " << number << endl;
	cout << "name: " << name << endl;
	cout << "ProjectItem: ";
	ProjectItem_show();
	cout << endl << "InvoiceQty: " << this->get_Qty() << endl;
	cout << "payOption: ";
	payOption_show();
	cout << endl;
	if (payOption == 2)
	{
		cout << "Accountnumber: " << account << endl;
		cout << "Account Owner: " << this->get_name();
	}
}


SYSTEMTIME get_time()
{
	SYSTEMTIME sys;
	GetLocalTime(&sys);
	return sys;
}

ostream& operator<<(ostream& os, const BillHeader& bil)
{
	static int count = 1000;
	count = count + 1;
	SYSTEMTIME sys;
	sys = get_time();

	os << "data: {\nbillNo: " << "BL";
	printf("%4d%02d%02d", sys.wYear, sys.wMonth, sys.wDay);
	cout << count << endl<<"}\n\n";
	return os;
}

BillLines::BillLines()
{
	cout <<endl <<  "BillLines:{\n";
	invoiceDate = "null";
	cout << "Please enter your amount: ";
	getline(cin, amount);
	cout << "Then input the status of the bill: 1 for normal, 2 for lost";
	cin >> status;
	cout << "Then what is the remark? ";
	cin.get();
	getline(cin, remark);
	cout << "}\n";
}

bool BillLines::check_lines() const
{

	if ((status != 1) && (status != 2))
	{
		if (check_fal == 0)
		{
			cout << "Ê§°Ü\nmessage: please choose the correct status.\n";
			check_fal++;
		}
		else
			cout << "\nmessage: please choose the correct status.\n";
		return 0;
	}
	else if (amount.size() == 0)
	{
		if (check_fal == 0)
		{
			cout << "Ê§°Ü\nYou have not input remark yet.\n";
			check_fal++;
		}
		else
			cout <<"\nYou have not input remark yet.\n"; 
		return 0;
	}
	return 1;
}


void BillLines::get_result_line() const
{
	SYSTEMTIME sys;
	sys = get_time();
	cout << "Billlines:{\n" << "invoiceDate: ";
	printf("%4d-%02d-%02d", sys.wYear, sys.wMonth, sys.wDay);
	cout << endl << "Amount: " << amount << endl;
	cout << "Status: ";
	get_status();
	cout << endl << "remark: " << remark << endl;
}


