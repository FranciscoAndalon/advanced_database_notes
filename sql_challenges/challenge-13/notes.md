# Lesson 08 Notes — ETL + Data Warehouse

## Step 1: Source Tables

I created an OLTP structure for a ticket system.

The tickets table stores the current state of each ticket. The ticket_assignments table stores history, so we can know who had the ticket at different moments.

I also created an agents table because tickets need to be assigned to real agents.

## Step 2: Sample Data

I inserted 4 agents and 5 tickets.

At least one ticket gets reassigned so the history table can prove that the old and new assignments are both tracked.

## Step 3: Trigger

The trigger runs after a ticket is inserted or when assigned_to changes.

On insert, it creates the first assignment history row.

On update, it closes the old active assignment by setting valid_to, then inserts a new current assignment with valid_to = NULL.

This matters because the current ticket row only shows the latest assignee, but the history table shows what happened before.

## Step 4: Data Warehouse Tables

I created a small star schema.

dim_agent stores agent information, and fact_ticket_daily stores daily numbers for created and resolved tickets.

The fact table uses agent_key, which is a warehouse key, instead of depending directly on the OLTP agent_id.

## Step 5: Populate dim_agent

I loaded agents from the OLTP agents table into the warehouse dim_agent table.

This is part of the transform/load process because the warehouse keeps its own dimension table.