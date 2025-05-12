# 🔐 Criminal Database Management System

A structured relational database designed to manage and store information related to criminal cases, including suspects, officers, victims, cases, trials, and evidence. Built as part of an academic project.

---

## 📌 Project Overview

This SQL-based project provides the backend database schema for a criminal records management system. The design supports data storage and relational querying for law enforcement, legal, and investigative purposes.

It includes multiple related entities such as:

- **Criminals**
- **Victims**
- **Police Officers**
- **Crimes**
- **Cases**
- **Evidence**
- **Courts**
- **Trials**

---

## 🧱 Database Schema

The system includes the following core tables:

| Table Name | Description |
|------------|-------------|
| `criminal` | Stores personal and identification details of criminal suspects |
| `officer`  | Contains data on law enforcement officers involved in cases |
| `victim`   | Information related to victims of reported crimes |
| `crime`    | Logs various types of crimes and crime details |
| `case`     | Links specific crimes with investigations and officers |
| `evidence` | Stores information on physical or digital evidence related to cases |
| `court`    | Contains court names and associated legal details |
| `trial`    | Manages details of court trials, outcomes, and decisions |

All tables are linked using primary and foreign keys to maintain data consistency and support complex queries.
