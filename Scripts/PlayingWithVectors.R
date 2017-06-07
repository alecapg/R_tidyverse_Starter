x<-5*6
is.vector(x)
length(x)
x[2]<-31
x[0]#not valid index
x<-1:20
y<-x**2#vectorises the operation
z<-y[-5]#dropping value in position 5
x+y
x+z#different length. Starts to recycle the vecto so it does x[20]+z[1], be careful since R does not worn if the two vectors are integer multiples.
x^y
y^x#this uses recycle to be computed
z^x
#everything that touches a missing value NA becomes a missing value!!!!
string<-c('Hello','workshop','participants!')
str(string)
c(9:11,200,x)
str(c(9:11,200,x))
str(c(9:11,200,pi,pi>3,string))#everything is treated as a char
c(9:11,200,x)^2#works
c(9:11,200,pi,pi>3,string)^2#does not work
str(c(9:11,200,pi,pi>3)) #numeric
str(c(9L:11L,200L,pi>3)) #integer
w<-rnorm(10)#random numbers from normal distribution
which(w<0)#position of elements <0
w[which(w<0)]
w[w<0]#gives the same thing since w<0 is a logical vector, and it keeps only the true
w[-c(2,5)]
str(list('ciao',pi,1:4,pi>3))#this preserve the nature of all the different elements. You can have different type of data
X<-list(vegetable ='cabbage',number='pi',seires=2:4,telling= pi>3)
str(X)
X$vegetable
X[1]#return the same value but as a list
str(X[1])
X[[3]]#[[]] returns the element exactly as $
X$seires
#nestes list
Y<-list(vegetable =list('cabbage','carrot','spinach'),
        number=list(c(pi,2.14,NA)),
        seires=list(2:4,1:5),telling= pi>3)
str(Y)
