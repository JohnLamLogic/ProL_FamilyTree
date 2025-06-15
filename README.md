# Prolog Family Tree Knowledge Base

A project that utilizes the declarative programming paradigm of Prolog to build a comprehensive genealogy system.

---

## Overview

This project utilizes the declarative programming paradigm of Prolog to create a comprehensive genealogy knowledge base. The system is built on a foundation of simple facts (e.g., who is male/female, who is married to whom, who is a parent of whom). From this core data, a powerful set of logical rules is used to infer a wide variety of complex family relationships, from simple siblings to nth cousins, once removed.

---

## Features

- **Knowledge Representation**: A large knowledge base of facts represents individuals and their direct relationships (e.g., `male(tim-ant)`, `married(jim-bat, meg-gum)`, `parent(del-emu, tye-emu)`).

- **Complex Rule Inference**: A powerful set of rules infers intricate family relationships, including `sibling`, `aunt-of`, `uncle-of`, `grandparent-of`, and even `is-nth-cousin-of(N, removed-up, M)`.

- **Recursive Rules**: Leverages recursion to define transitive relationships. For example, the `ancestor` rule calls itself to traverse up the family tree until the original ancestor is found.

- **Blood Relation Checking**: Includes a rule (`is-blood-related-to`) that can determine if two individuals share a common ancestor.

---

## How It Works

Instead of a step-by-step procedural approach, this project relies on defining logical rules and letting the Prolog engine find answers based on facts.

### Facts

The foundation is a set of simple, true statements about individuals and their direct relationships.

### Rules

More complex relationships are defined as rules that build upon these facts. For example, a "sibling" is defined as someone who shares a common parent.

### Queries

The user asks questions (queries) in the Prolog environment. The engine attempts to satisfy these queries by matching them against the facts and rules in the knowledge base.

---

## Code Snippet: The `great-aunt-of` Rule

This rule demonstrates how complex relationships are built from simpler, already-defined rules. It states that X is the great-aunt of Y if X is the aunt of one of Y's parents (P).

```prolog
related(X, is-great-aunt-of, Y) :-
    related(X, is-aunt-of, P),
    parent(Y, P).
```

---

## Technologies Used

- **Language**: Prolog (SWI-Prolog)
- **Paradigm**: Logic Programming, Declarative Programming
- **Core Concepts**: Knowledge Representation, Rule-Based Inference, Recursion

---

## Getting Started

### Prerequisites

- A Prolog interpreter, such as the free and open-source [SWI-Prolog](https://www.swi-prolog.org/)

### Installation & Execution

1. **Save the Code**: Save the Prolog code into a file (e.g., `family_tree.pl`).

2. **Start the Prolog Interpreter**:

   ```bash
   swipl
   ```

3. **Consult the File**:

   ```prolog
   ?- consult('family_tree.pl').
   ```

4. **Run Queries**:

   You can now ask questions based on the rules you've defined.

   - To find all siblings of `ann-ant`:

     ```prolog
     ?- sibling(ann-ant, Y).
     ```

   - To find the grandmother of `tim-ink`:

     ```prolog
     ?- related(X, is-grandma-of, tim-ink).
     ```

   - To find the second cousins of `mary-ant`:

     ```prolog
     ?- related(mary-ant, is-nth-cousin-of(2), Y).
     ```

5. **Find More Solutions**:

   After a query returns a result, you can press the semicolon key (`;`) to ask Prolog to search for alternative solutions.

