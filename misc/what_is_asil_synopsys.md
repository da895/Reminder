#    What is ASIL (Automotive Safety Integrity Level)? – Overview | Synopsys


Table of Contents
=================
<!-- vim-markdown-toc GFM -->

* [What is ASIL?](#what-is-asil)
* [-----------------------------------------------------------------](#-----------------------------------------------------------------)
* [viewport: 'width=device-width, initial-scale=1.0'](#viewport-widthdevice-width-initial-scale10)
* [What is ASIL?](#what-is-asil-1)
* [How do ASILs work?](#how-do-asils-work)
* [What are the challenges of ASILs?](#what-are-the-challenges-of-asils)
* [How are ASILs evolving?](#how-are-asils-evolving)
* [What are the benefits of ASILs?](#what-are-the-benefits-of-asils)
* [How does Synopsys help you meet ASIL requirements?](#how-does-synopsys-help-you-meet-asil-requirements)

<!-- vim-markdown-toc -->


What is ASIL? 
-----------------------------------------------------------------
---
description: |
    ASIL refers to Automotive Safety Integrity Level. It is a risk
    classification system defined by the ISO 26262 standard for the
    functional safety of road vehicles. Learn more. 
keywords: ASIL
last-modified: '2020-9-02 11:16:06 AM'
title: |
    What is ASIL (Automotive Safety Integrity Level)? – Overview | Synopsys
    Automotive
    What is ASIL (Automotive Safety Integrity Level)? – Overview | Synopsys
    Automotive 
viewport: 'width=device-width, initial-scale=1.0'
---

What is ASIL? 
-----------------------------------------------------------------


ASIL refers to Automotive Safety Integrity Level. It is a risk
classification system defined by the ISO 26262 standard for the
functional safety of road vehicles.

The standard defines functional safety as “the absence of unreasonable
risk due to hazards caused by malfunctioning behavior of electrical or
electronic systems.” ASILs establish safety requirements―based on the
probability and acceptability of harm―for automotive components to be
compliant with [ISO 26262](https://www.iso.org/standards.html).

There are four ASILs identified by ISO 26262―A, B, C, and D. ASIL A
represents the lowest degree and ASIL D represents the highest degree of
automotive hazard.

Systems like airbags, anti-lock brakes, and power steering require an
ASIL-D grade―the highest rigor applied to safety assurance―because the
risks associated with their failure are the highest. On the other end of
the safety spectrum, components like rear lights require only an ASIL-A
grade. Head lights and brake lights generally would be ASIL-B while
cruise control would generally be ASIL-C.


![ASIL Classifications](/misc/asil-classifications.jpg.imgw.850.x.jpg)


How do ASILs work? 
-----------------------------------------------------------------

ASILs are established by performing hazard analysis and risk assessment.
For each electronic component in a vehicle, engineers measure three
specific variables:

-   Severity (the type of injuries to the driver and passengers)
-   Exposure (how often the vehicle is exposed to the hazard)
-   Controllability (how much the driver can do to prevent the injury)

Each of these variables is broken down into sub-classes. Severity has
four classes ranging from “no injuries” (S0) to “life-threatening/fatal
injuries” (S3). Exposure has five classes covering the “incredibly
unlikely” (E0) to the “highly probable” (E4). Controllability has four
classes ranging from “controllable in general” (C0) to “uncontrollable”
(C3).

All variables and sub-classifications are analyzed and combined to
determine the required ASIL. For example, a combination of the highest
hazards (S3 + E4 + C3) would result in an ASIL D classification. 


What are the challenges of ASILs? 
------------------------------------------------------------------------------


Determining an ASIL involves many variables and requires engineers to
make assumptions. For example, even if a component is hypothetically
“uncontrollable” (C3) and likely to cause “life-threatening/fatal
injuries” (S3) if it malfunctions, it could still be classified as ASIL
A (low risk) simply because there’s a low probability of exposure (E1)
to the hazard.

ASIL definitions are informative rather than prescriptive, so they leave
room for interpretation. A lot of room. ASIL vocabulary relies on
adverbs (usually, likely, probably, unlikely). Does “usually” avoiding
injury mean 60% of the time or 90% of the time? Is the probability of
exposure to black ice the same in Tahiti as it is in Canada? And what
about traffic density? Rush hour in Los Angeles vs. late morning on an
empty stretch of road in the Australian Outback?

Simply put, ASIL classification depends on context and interpretation. 


How are ASILs evolving? 
--------------------------------------------------------------------

Given the guesswork involved in determining ASILS, the [Society of
Automotive Engineers (SAE)](https://www.sae.org/) drafted J2980,
“Considerations for ISO 26262 ASIL Hazard Classification” in 2015. These
guidelines provide more explicit guidance for assessing Exposure,
Severity, and Controllability for a given hazard. J2980 continues to
evolve―the SAE published a revision in 2018.

With the evolution of the self-driving car, ISO 26262 will need to
revisit the definition of “Controllability,” which currently pertains to
the human driver. As the standard reads now, the absence of a human
driver means that Controllability will always be C3, the extreme of
“uncontrollable.” The other variables of Severity (injury) and Exposure
(probability) will no doubt require re-examination as well.


What are the benefits of ASILs?
----------------------------------------------------------------------------

ISO 26262 is a goal-based standard that’s all about “preventing harm.”
Despite their challenges, ASIL classifications are intended to “prevent
harm” and help us achieve the highest safety rating possible for myriad
automotive components across a long and often disjointed supply chain.

Key benefits include:

-   Establishing safety requirements to mitigate risks to acceptable
    levels
-   Managing and tracking safety requirements
-   Ensuring that standardized safety procedures have been followed in
    the final product 


How does Synopsys help you meet ASIL requirements? 
-----------------------------------------------------------------------------------------------

The Synopsys [DesignWare IP](https://www.synopsys.com/designware-ip/ip-market-segments/automotive.html)
portfolio with safety packages is ASIL B and D ready, ISO 26262
certified, and designed for use in safety-critical applications. Our
ASIL-certified IP also accelerates SoC development for applications like
[advanced driver assistance systems
(ADAS)](/automotive/what-is-adas.html).

Our [safety packages](https://www.synopsys.com/designware-ip/ip-market-segments/automotive/functional-safety.html)
consist of failure modes effects and diagnostics analysis (FMEDA)
reports, safety manuals, and certification reports to accelerate safety
assessments and help you reach your target ASILs. Using DesignWare IP
also reduces supply chain risk and accelerates the entire process of
achieving SoC-level functional safety (from requirements specification
to design, implementation, integration, verification, validation, and
configuration). 

