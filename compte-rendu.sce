// ***************************************************************************
// ** PARTIE 1 ***************************************************************
// ***************************************************************************


// ************
// * Question 1

// `spec` donne les valeurs propres d’une matrice, dans un vecteur
// La commande qui permert permet de définir une matrice identité est `eye`


// ************
// * Question 2

A = [
     [1, 0, 3, 1],
     [1, 2, 0, 1],
     [0, 1, 3, 0]
]

// taille de A
size(A)

// première ligne
l1 = A(1,:)

// dernière colonne
c4 = A(:,4)

// troisième colonne
c3 = A(:,3)

// Partie triangulaire supérieure
triu(A)

// Partie triangulaire inférieure
tril(A)


// ************
// * Question 3

// Construction alternative de la matrice identité 10x10 par `ones` et `diag`

diag(ones(10,1))

// Construction d'une matrice tridiagonale particulière

m0 = diag( 2 * ones(10, 1))
m1 = diag(     ones(9 , 1), -1)
m2 = diag(-1 * ones(9 , 1),  1)
m0 + m1 + m2

// ************
// * Question 4

clf

x = linspace(0, 2*%pi, 6)
plot(x, sin(x))

x = linspace(0, 2*%pi, 21);
plot(x, sin(x));

xtitle("Graphe de la fonction Sinus sur [0,2PI]");
legend("sin");

// ***************************************************************************
// * PARTIE 3 ****************************************************************
// ***************************************************************************

// ************
// * EXERCICE 1

x = 1e30               // 1.000D+30 === 10^{30}
y = 1e-8               // 1.000D-8  === 10^{-8}
z = ((y + x) - x) / y  // 0
w = (y + (x - x)) / y  // 1

// Analyse des résultats
//
// On rappelle que dans scilab, les nombres réels sont représentés par un 
// nombre flottant dont la mantisse est codée sur 52 bits et l'exposant 
// sur 11 bits. On remarque que 2^52 ~ 4x10^{15}, en d'autres termes, cette 
// représentation permet d'atteindre ~ 16 chiffres représentatifs (décimaux).
//
// Dans le calcul de z, l'opération y + x donne, en notation décimale
//   x + y = 1000000000000000000000000000000,00000001
// Cette valeur présente 39 chiffres significatifs, ce qui est bien au delà 
// des capacités de repésentation en double précision.
//
// De fait, dans x + y, y se trouve absorbé (par sa faible pondération), 
// et l'on obtient x + y = x bien que y soit non nul.
//
// Dans le calcul de w, l'opération x - x produit un zéro, calculer w revient
// alors à diviser y par lui même, ce qui donne 1, le calcul est correct.


// ************
// * EXERCICE 2

// Pour cette étude, deux méthodes de calculs sont proposées. Les résultats
// sont identiques par chaque méthode. La première est immédiate. La seconde,
// récursive permet de suivre l'évolution des calculs pas à pas.

x = 0:0.1:4

// ** Méthode 1

y = x ** (0.5 ** 128)
z = y ** (2.0 ** 128)

// ** Méthode 2

function y = recursive_root(x, n)
    if (n == 0) then
        y = 1
    elseif (n == 1) then
        y = sqrt(x)
    else 
        y = sqrt(recursive_root(x, n - 1))
    end
    disp(y)
endfunction

function y = recursive_power(x, n)
    if (n == 0) then
        y = x;
    else
        z = recursive_power(x, n - 1)
        y = z .* z;
    end
    disp(y)
endfunction

y = recursive_root(x, 128)
z = recursive_power(y, 128)

xtitle("Graphe de la fonction Sinus sur [0,2PI]");

clf
plot2d(x, y, style=[color("red")])
plot2d(x, z, style=[color("blue")])
legend("y = recursive_root(x, 128)", "z = recursive_power(y, 128)");


// Analyse des résultats
// Afin de ce faire une idée du processus de calcul, lançons la commande
//   recursive_root(4, 128)
// On observe alors que la limite de la fonction tends vers 1 jusqu'à venir
// s'écraser sur cette valeur (ici lors de la 26e itération). La valeur est 
// tellement proche de 1 que la machine ne peut plus représenter 
// les variations.

// RQ : analyser les cas 
// - x > 1
// - x = 1
// - 0 < x < 1

// Impossible à redresser

// ** 1.4 *********************************************************************
// ** FONCTIONS ****************************************************************

// Integrale

function r = compute(n)
    if (n == 0) then
        r = exp(1) - 1
    else 
        r = exp(1) - (n) * compute(n - 1)
    end
endfunction

compute(20)

// Développement en série

function y = serial(n)
    y = 0
    for k = 0:n
        y = y + 1 / (factorial(k) * (k + 21))
    end
endfunction

serial(1000000)


// *****************************************************************************
// ** EXERCICE 4 ***************************************************************

function y = f(x)
    y = (x ** 20) * exp(x)
endfunction

function r = rectangle(f, a, b, n)
    d = (b - a) / (n + 1)
    x = a
    r = 0
    for i = 0:n
        r = r + d * f(x)
        x = x + d
    end
endfunction

rectangle(f, 0, 1, 1000000)

// *****************************************************************************
// ** EXERCICE 6 ***************************************************************

function y = aux(x, n)
    y = sin(2 * (2 * n + 1) * %pi * x) / (2 * n + 1)
endfunction

function y = f(x, n)
    y = 0
    for k = 0:n
        y = y + aux(x, k)
    end
    y = (4 / %pi) * y
endfunction

n = input("Donner un entier : ")
x = linspace(-0.5, 0.5, 1000)
y = f(x, n)
clf
plot2d(x, y, style=[color("blue")])
title("Tracé de la série de Fourier tronquée de la fonction f, n = " + string(n))



// *****************************************************************************
// ** EXERCICE 7 ***************************************************************


A = [
    [1 + %i,     %i, 2],
    [3,      2 + %i, 1],
    [1,          %i, 6]]

function r = lambda(A, k)
    r = 0
    s = size(A)
    for j = 1:s(2)
        if j ~= k then
            r = r + abs(A(k,j))
        end
    end
endfunction

function circle(z, r, c)
    t = linspace(%pi, 0, 1000)
    plot2d(real(z) + cos(t) * r, imag(z) + sin(t) * r, style=[color(c)])
    plot2d(real(z) + cos(t) * r, imag(z) - sin(t) * r, style=[color(c)])
endfunction

function gershgorin(A)
    s = size(A)
    c = ["blue", "red", "green"]
    for i = 1:s(1)
        circle(A(i,i), lambda(A, i), c(i))
    end
endfunction

clf
gershgorin(A)
