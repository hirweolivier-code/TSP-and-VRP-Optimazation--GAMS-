# Vehicle Routing Optimization with GAMS

## 📌 Project Overview

This project focuses on solving routing optimization problems using mathematical programming.


The project consists of two main optimization tasks:

1. Traveling Salesman Problem (TSP)
2. Multi-Vehicle Routing Problem

The objective is to determine efficient routes while minimizing the total travel distance.

---

## 🧩 Task 1 – Traveling Salesman Problem

The first task determines an optimized tour through a network of 40 nodes and a depot.

The optimization produced a total distance of:

**Objective Function Value = 331**

The resulting route was:

`0 → 8 → 40 → 39 → 18 → 16 → 6 → 17 → 3 → 28 → 31 → 30 → 38 → 25 → 4 → 24 → 11 → 29 → 9 → 13 → 1 → 22 → 19 → 20 → 33 → 21 → 32 → 37 → 5 → 14 → 34 → 7 → 2 → 10 → 23 → 35 → 36 → 27 → 15 → 12 → 26 → 0`

The model also considers the position of nodes within the tour and arrival times.

---

## 🚚 Task 2 – Multi-Vehicle Routing

The second task extends the routing problem to multiple vehicles.

The optimization produced a total distance of:

**Objective Function Value = 201**

Example optimized vehicle routes include:

**Vehicle 1**

`0 → 8 → 13 → 15 → 7 → 2 → 10 → 0`

**Vehicle 2**

`0 → 17 → 3 → 18 → 5 → 4 → 14 → 20 → 0`

**Vehicle 3**

`0 → 16 → 6 → 9 → 19 → 11 → 1 → 12 → 0`

---

## 📊 Solution Quality Analysis

For both optimization tasks, the relationship between **computation time** and **solution quality** was analyzed.

Solution quality was evaluated using the relative gap between the current best solution and the optimal solution.

The analysis illustrates how increasing computation time can improve the quality of the optimization solution.

---

## 🛠️ Tools & Methods

- GAMS
- Mathematical Optimization
- Operations Research
- Traveling Salesman Problem (TSP)
- Vehicle Routing Problem (VRP)
- Route Optimization
- Solution Gap Analysis


