#include <iostream>
#include <fstream>
#include <string>

using namespace std;

int main(int argc, char* argv[]){

    const char* inputFileName = argv[1];
    const char* outputFileName = argv[2];

    ifstream inputFile(inputFileName);
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
    ofstream outputFile(outputFileName);
    if (!outputFile) {
        cerr << "Error opening file.\n";
        return 1;
    }
    outputFile << "sum of numbers mutiplied by 15: " << newResults << endl;
    inputFile.close();
    outputFile.close();
    return 0;
}