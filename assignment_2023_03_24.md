
Que 1. Determine the highest normal form of this relation scheme.  
     
   The relation scheme student Performance (StudentName, CourseNo, EnrollmentNo, Grade) has  
   the following functional dependencies:  
   
   StudentName, courseNo → grade  
   EnrollmentNo, courseNo → grade  
   StudentName →EnrollmentNo  
   EnrollmentNo →StudentName

Ans : 

To calculate the highest normal form of student Performance relationship schema let's find the candidate keys first.  

Candidate keys: {StudentName, CourseNo, EnrollmentNoCourseNo}  
     
Prime Attributes: {StudentName, CourseNo, EnrollmentNo}  
     
Non Prime Attributes: {Grade}  
   
   
A relationship is in BCNF form when it satisfies the following condition:  
- A column or set of columns that uniquely determines the values in other columns in the relation, is a candidate key.
       
       Here for 
       {
            StudentName →EnrollmentNo  
            EnrollmentNo →StudentName
       } 
       these FDs in the relationship is breaking the rule.

- Now for 3NF, a relationship is in 3NF if **LHS is a Candidate Key** or **RHS is a Prime Attribute**.  
       There for in first 2 relationship LHS is the Candidate key and for the last 2 relationship RHS is the prime attribute. So the FDs are satisfying all the conditions for 3NF.
   
- So, **the highest normal form of this relation scheme is the Third Normal Form (3NF)**. Any relation that is in the Third Normal Form (3NF) must also be in the Second Normal Form (2NF) and the First Normal Form (1NF).
_______________________

Que 2. Suppose you are given a relation R= (A, B, C, D, E ) with the following functionaldependencies:{CE →D, D→B, C →A}

    a. Find all candidate keys.  
    b. Identify the best normal form that R satisfies (1NF, 2NF, 3NF, or BCNF).  
    c. If the relation is not in BCNF, decompose it until it becomes BCNF. At each step, identify a new relation, decompose and re-compute the keys and the normal forms they satisfy.

Ans:

a .

As CE is missing in the RHS of every FDs, CE must be present in the candidate keys. Now if I add A,B,D that will be the super key but candidate key is the minimal of super key.  
   
   CE+: A, C, E, D, B
   
   Candidate Keys: {CE}  
     
   Prime-Attributes: {C,E}  
     
   NonPrime-Attributes: {A,D,B}
   
b .

The functional dependencies {CE → D, D → B, C → A} themselves are in 1NF since each left-hand side and right-hand side of each dependency is a single attribute. So he best normal form that R satisfies (1NF, 2NF, 3NF, or BCNF) is **1NF**.
   
c .

For 2NF we need to check that the partial dependencies are present or not on the relation. conditions for partial dependencies are as following:  
   - LHS must be proper subset of Candidate keys and RHS must be a Non Prime Attribute.  
   - Here C → A breaking the rule so the decomposition will be  R (A, B, C, D, E )= R1(B,D,E) and R2(A,C) to make lossless decomposition R (A, B, C, D, E ) = R1(B,D,E,C) and R2(A,C)
   
For 3NF LHS must be Candidate key or RHS must be Prime Attribute.  
R1(B,D,E,C) : 

candidate key : {CE}

Prime Attributes : {C,E}
 
NonPrime Attributes : {B,D}  

FD D → B breaking the rule because neither D is the CK nor B is the Prime attribute. so  

R1(B,D,E,C)= R11(C,E),R12(B,D)  
To make it lossless decomposition: R1(B,D,E,C)= R11(C,E,D),R12(B,D)
   
Now the relationship is in BCNF. Because here every column or set of columns that uniquely determines the values in other columns in the relation, is a candidate key.
   
R(A, B, C, D, E ) = R11(C,E); R12(B,D); R2(A,C)

_______________________

Que 3. You are given the following set F of functional dependencies for relation  
   
   R(A, B, C, D, E, F):  
   F={ABC →D, ABD→E, CD→F, CDF →B, BF →D}  
   a. Find all keys of R based on these functional dependencies.  
   b. Is this relation in Boyce-Codd Normal Form? Is it 3NF? Explain your answers.

Ans :

   a.  
   ABC+ = A,B,C,D,E,F  
     
   ACD+ = A,C,D,F,B,D,E  
     
   Candidate key: {ABC,ACD}  
     
   Prime Attributes: { A, B, C, D }  
     
   NonPrime Attributes: {E,F}  
     
   b.  
   ABC → D: Since ABC is a candidate key of R, this functional dependency satisfies the condition for BCNF.  
     
   ABD → E: The attribute set ABD is not a superkey of R, as it does not contain all the attributes in the relation. Therefore, this functional dependency violates BCNF.  
     
     
   CD → F: The attribute set CD does not contain the candidate keys ABC or BF, and is not a superkey of R. Therefore, this functional dependency violates BCNF.  
     
     
   CDF → B: The attribute set CDF does not contain the candidate keys ABC or BF, and is not a superkey of R. Therefore, this functional dependency violates BCNF.  
     
     
   BF → D: Since BF is a candidate key of R, this functional dependency satisfies the condition for BCNF.
   
For 3NF, the relation is not in 3NF because in productions  

ABD -> E, ABD is not a candidate key and E is not a prime attribute.  
CD→F, CD is not a candidate key and F is not a prime attribute.  
CDF →B this is in 3NF because B is the prime attribute.  
BF →D again D is the prime attribute so this FD is in 3NF.

_______________________

Que 4. Write the advantages and disadvantages of normalization.
   
Advantages:
   
- Normalization reduces data redundancy by breaking down larger tables into smaller tables and linking them through relationships. This can help to conserve disk space and reduce the amount of storage required for a database.
   
- Normalization helps to improve data integrity by ensuring that each table contains only unique and relevant data, and that each table has a primary key that uniquely identifies each record.
   
Disavantages:
- Normalization can make the database more complex, which can increase the amount of time required for design and development.
      
- Over-normalization can lead to poor database performance, as excessive table joins and queries may be required to retrieve data from the database.

_______________________

Que 5. Determine the decomposition.  
   Consider the schema R = (S T U V) and the dependencies S → T, T → U, U → V, and V → S.  
   Let R = (R1 and R2) be a decomposition such that R1 ∩ R2 ≠ ∅

Ans :
   
   Candidate keys: {S,T,U,V}  
     
   Prime Attributes: {S,T,U,V}  
     
   Non Prime Attributes: {∅}  
   
   Create R1 with the attributes in the candidate key:
   
   We can create R1 with the attributes S and the attribute(s) that are functionally dependent on S. From the given dependencies, we can see that T is functionally dependent on S. Therefore, we can create
   
   R1 = (S, T).
   Create R2 with the remaining attributes:
   
   We can create R2 with the attributes that are not in R1. From the given dependencies, we can see that U is functionally dependent on T, and V is functionally dependent on U. Therefore, we can create
   
   R2 = (T, U, V).
   R(S T U V)=R1(S,T);R2(T,U,V)
   The intersection of R1 and R2 is not empty:
   
   Since R1 and R2 have one attribute in common (T), their intersection is not empty.