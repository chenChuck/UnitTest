#include"utest.hpp"
#include<iostream>
using namespace std;
int box::getlength(){
	return this->length;
}
int box::getwight(){
	return this->wight;
}
int box::gethight(){
	return this->hight;
}
int box::setlength(int x){
	this->length = x;
	return 0;
}
int box::setwight(int x){
	this->wight = x;
	return 0;
}
int box::sethight(int x){
	this->hight = x;
	return 0;
}
int box::getbulk(int x){
	if (x > 10) {
		return (this->length*this->wight*this->hight);
	} else {
		return (this->length*this->wight*this->hight);
	}
}
int box::getarea(){
	return (this->length*this->wight*2 + this->hight*this->wight*2 + this->hight * this->length *2);
}

