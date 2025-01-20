# Approximate_multiplier
About approximate multipliers
Approximate 4x4 Bit Multiplier
This repository presents a 4x4 bit approximate multiplier designed using approximation techniques for reduced area and power consumption while maintaining acceptable error margins.

#Overview
The implementation is based on the methods from the paper Design and Analysis of Approximate Multipliers, with custom approximations for the approximate compressor. 

It satisfies the following criteria:
Mean Relative Error (MRE): Less than 15% (achieved: 12.14%)
Number of LUTs: Less than 12 (achieved: 6)
Power Consumption: 29 mW

#Approximation Techniques

#Half Adder Approximation
Sum is approximated using a simple logical OR operation instead of XOR.
This reduces complexity but introduces minor errors in certain cases.
Exact Implementation:
Sum = A ⊕ B
Carry = A ⋅ B
Approximated Implementation:
Sum = A + B
Carry = A ⋅ B

#Full Adder Approximation
The sum and carry are approximated to reduce hardware requirements.
Only significant carry bits are retained to maintain acceptable accuracy.
Exact Implementation:
Sum = A ⊕ B ⊕ Cin
Carry = (A ⋅ B) + (B ⋅ Cin) + (Cin ⋅ A)
Approximated Implementation:
Sum = (A + B) + Cin
Carry = B

#Partial Product Transformation
Partial products are approximated by propagating and generating terms in a simplified manner.
Some exact terms are retained to ensure a balance between accuracy and resource utilization.

#Partial Product Reduction with Compressors
Compressors are used to reduce partial product trees efficiently.
A custom approximation technique is applied to reduce area and power while introducing minimal error.
Approximated Compressor:
Carry = Cin
Sum = (A ⊕ B) + (C + D)
Carry-out (Cout) = (A ⋅ B) + (C ⋅ D)

#Final Summation
Approximate and exact adders are used for the final summation of reduced partial products, balancing performance and accuracy.

#Results
Mean Relative Error (MRE): 12.14%
Power Utilization: 29 mW
LUT Utilization: 6 (less than 12)

#Screenshots
1.Mean Relative Error (MRE):
![error_screenshot](https://github.com/user-attachments/assets/4e8c8ef7-d81a-49a7-9371-538f757b89cb)

2.Utilization Report:
![utilization_screenshot](https://github.com/user-attachments/assets/8a5066c7-db95-4715-8824-932bb6b7390b)

3.Power Report:
![power_screenshot](https://github.com/user-attachments/assets/a860c62e-acab-4b0f-83a5-72dcfd64874a)

