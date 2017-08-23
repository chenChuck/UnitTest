#include "gtest/gtest.h"
#include "../utest.hpp"

TEST(box,boxtest)
{
	box a;

	EXPECT_EQ(0,a.sethight(10));
	EXPECT_EQ(0,a.setwight(10));
	EXPECT_EQ(0,a.setlength(10));
	EXPECT_EQ(1000,a.getbulk(11));
	EXPECT_EQ(1000,a.getbulk(1));
	EXPECT_EQ(10,a.gethight());
	EXPECT_EQ(10,a.getwight());
	EXPECT_EQ(10,a.getlength());
	EXPECT_EQ(600,a.getarea());
}
