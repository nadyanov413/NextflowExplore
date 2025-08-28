#include <iostream>
#include <fstream>
#include <string>

using namespace std;

int main(){
    ifstream inputFile("results.txt");
    if (!inputFile) {
        cerr << "Error opening file.\n";
        return 1;
    }
   
    int size;
    string lable;
    int newResults = 0;
    inputFile >> lable >> lable >> lable >> size;
    //process data
    newResults = size * 15;

    // Save data
    ofstream outputFile("newResults.txt");
    if (!outputFile) {
        cerr << "Error opening file.\n";
        return 1;
    }
    outputFile << "sum of numbers mutiplied by 15: " << newResults << endl;
    inputFile.close();
    outputFile.close();
    return 0;
}