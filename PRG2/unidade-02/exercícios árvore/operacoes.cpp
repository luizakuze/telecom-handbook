#include <iostream>
#include <prglib.h>

using namespace std;
using prglib::arvore;

int main() {
    arvore<int> arv = {4,3,6,1,2,6};
    
    auto l1 = arv.listeInOrder();
    auto l2 = arv.listeEmLargura();
    
    cout << "In Order" << endl;
    for (auto & x: l1) {
        cout << x << ' ';
    }
    cout << endl;

    // In Order é feito implicitamente na árvore
    for (auto & x: arv) {
        cout << x << ' ';
    }

    cout << "Em Largura" << endl;
    for (auto & x: l2) {
        cout << x << ' ';
    }
    cout << endl;

    return 0;
}
