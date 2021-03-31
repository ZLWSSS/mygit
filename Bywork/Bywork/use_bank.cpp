#include"Bank_expense.h"
#include<vector>

extern int check_fal;
int main()
{
	BillHeader Test_1 = BillHeader();
	BillLines* ps[20];
	int i;
	for (i = 0; i < Test_1.get_Qty(); i++)
	{
		cout << "The #" << i + 1 << "Lines:\n";
		ps[i] = new BillLines();
	}

	//check
	cout << endl << endl << "Status: ";
	if (Test_1.check_bill())
	{
		for (i = 0; i < Test_1.get_Qty(); i++)
		{
			if (ps[i]->check_lines())
				continue;
		}
	}

	if (check_fal == 0)
	{
		cout << "³É¹¦\n";
		cout << "message: \n" << Test_1;
	}

	//show the result
	cout << endl;
	Test_1.show_result_bil();
	cout << endl<<endl;

	for (i = 0; i < Test_1.get_Qty(); i++)
	{
		cout << "The lines#" << i + 1 << ":\n";
		ps[i]->get_result_line();
		cout << endl;
	}
	//delete ptr
	for (i = 0; i < Test_1.get_Qty(); i++)
	{
		delete ps[i];
	}
	return 0;
}
