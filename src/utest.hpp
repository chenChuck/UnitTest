#ifndef __UTEST__
#define __UTEST__

	
	class box {
		
		public:

			int length;
			int wight;
			int hight;
			
			int getlength();
			int getwight();
			int gethight();

			int setlength(int x);
			int setwight(int x);
			int sethight(int x);

			int getbulk(int x);
			int getarea();
	};



#endif
