# apb_interfaced_spi_rtl_design_and_uvm_based_verification


## 📌 Project Overview

This project implements and verifies an **APB-interfaced SPI Master IP** using **Verilog/SystemVerilog and UVM**.

The SPI Master is controlled through an **AMBA APB interface** and communicates with an external SPI slave using standard SPI signals.

A complete **UVM-based verification environment** is developed to verify the RTL using directed and constrained-random test scenarios.

The verification environment includes:

* APB Agent
* SPI Agent
* UVM Register Abstraction Layer (RAL)
* Register Adapter
* Register Predictor
* Scoreboard
* Functional Coverage
* SystemVerilog Assertions (SVA)
* Directed configuration-based testing
* Constrained-random testing
* Reset verification
* Low-power verification

---

# 🎯 Project Objectives

The main objectives of this project are:

1. Design an **APB-interfaced SPI Master** RTL.
2. Implement configurable SPI communication.
3. Support different SPI clock polarity and clock phase configurations.
4. Support MSB-first and LSB-first data transfer.
5. Verify APB register read/write operations.
6. Develop a reusable **SystemVerilog/UVM verification environment**.
7. Implement **UVM RAL** for register-level verification.
8. Develop a scoreboard for expected-vs-actual comparison.
9. Implement functional coverage and cross coverage.
10. Use SystemVerilog Assertions for protocol and design checks.
11. Verify reset and low-power behavior.

---

# 🏗️ System Architecture

The complete project consists of two major parts:

```text
                  APB INTERFACED SPI MASTER
                           |
          +----------------+----------------+
          |                                 |
          v                                 v
      RTL DESIGN                     UVM VERIFICATION
          |                                 |
    APB Interface                      APB Agent
    Register File                      SPI Agent
    SPI Control FSM                    RAL
    Shift Register                     Scoreboard
    Baud Generator                     Coverage
                                       Assertions
```
1
🧩 RTL Design

The RTL is organized into functional blocks:

1. APB Interface

Handles:

APB setup and access phases
Register read/write operations
Address decoding
Control and status register access
2. SPI Control FSM

Controls:

SPI transaction start
Chip-select generation
Clock generation
Serial data transmission
Serial data reception
Transfer completion
3. Shift Register

Used for:

Parallel-to-serial conversion for MOSI
Serial-to-parallel conversion for MISO
MSB-first / LSB-first operation
4. Clock / Baud Generator

Generates the SPI clock based on the configured divider and system clock.
## 📐 Pictorial Architecture

The repository contains a detailed pictorial architecture showing:

* APB Master
* APB-SPI DUT
* APB interface
* Register file
* SPI control FSM
* Shift register
* Baud-rate generator
* SPI slave
* APB UVM Agent
* SPI UVM Agent
* RAL
* Register predictor
* Scoreboard
* Functional coverage
* SVA assertions

```text
docs/
└── apb_spi_uvm_architecture.png
```

---

# 🔷 RTL Block Diagram

```text
                         APB MASTER
                       (SoC / CPU)
                            |
                            | APB
                            v
              +-----------------------------+
              |       APB-SPI MASTER        |
              |            DUT              |
              |                             |
              |  +-----------------------+  |
              |  |     APB Interface     |  |
              |  +-----------+-----------+  |
              |              |              |
              |  +-----------v-----------+  |
              |  |   Control / Status    |  |
              |  |      Registers        |  |
              |  +-----------+-----------+  |
              |              |              |
              |  +-----------v-----------+  |
              |  |    SPI Control FSM    |  |
              |  +-----------+-----------+  |
              |              |              |
              |  +-----------v-----------+  |
              |  |     Shift Register    |  |
              |  +-----------+-----------+  |
              |              |              |
              |  +-----------v-----------+  |
              |  |   Baud Rate Generator |  |
              |  +-----------------------+  |
              +---------------+-------------+
                              |
                    +---------+---------+
                    |                   |
                   SPI                 SPI
                 Signals             Signals
                    |                   |
                    v                   v
              +---------------------------+
              |        SPI SLAVE          |
              +---------------------------+
```

---

# 🔌 Interfaces

## APB Interface

The APB interface is used to configure and control the SPI Master.

| Signal    | Description         |
| --------- | ------------------- |
| `PCLK`    | APB clock           |
| `PRESETn` | Active-low reset    |
| `PADDR`   | APB address         |
| `PSEL`    | Peripheral select   |
| `PENABLE` | APB enable          |
| `PWRITE`  | Read/write control  |
| `PWDATA`  | APB write data      |
| `PRDATA`  | APB read data       |
| `PREADY`  | Transfer completion |
| `PSLVERR` | APB error response  |

## SPI Interface

| Signal | Description            |
| ------ | ---------------------- |
| `SCLK` | SPI clock              |
| `MOSI` | Master Out Slave In    |
| `MISO` | Master In Slave Out    |
| `CS_N` | Active-low chip select |

---

# ⚙️ SPI Features

The SPI Master supports:

* Full-duplex SPI communication
* Configurable CPOL
* Configurable CPHA
* MSB-first / LSB-first data transfer
* Programmable SPI clock generation
* APB-controlled configuration
* Register-based data transfer
* Reset functionality
* Low-power functionality

---

# 🔄 SPI Configuration

The three main SPI configuration bits used for verification are:

| Parameter | Description      |
| --------- | ---------------- |
| `CPOL`    | Clock Polarity   |
| `CPHA`    | Clock Phase      |
| `LSBFE`   | LSB First Enable |

Each parameter has two possible values.

Therefore:

```text
CPOL × CPHA × LSBFE

2 × 2 × 2 = 8 combinations
```

The verification environment covers all **8 combinations**.

---

# 📊 SPI Configuration Modes

| CPOL | CPHA | LSBFE | Configuration     |
| ---: | ---: | ----: | ----------------- |
|    0 |    0 |     0 | Mode 0, MSB-first |
|    0 |    0 |     1 | Mode 0, LSB-first |
|    0 |    1 |     0 | Mode 1, MSB-first |
|    0 |    1 |     1 | Mode 1, LSB-first |
|    1 |    0 |     0 | Mode 2, MSB-first |
|    1 |    0 |     1 | Mode 2, LSB-first |
|    1 |    1 |     0 | Mode 3, MSB-first |
|    1 |    1 |     1 | Mode 3, LSB-first |

---

# 🧪 UVM Verification Architecture

The verification environment is developed using **SystemVerilog and UVM**.

```text
                         +----------------+
                         |    uvm_test    |
                         +-------+--------+
                                 |
                         +-------v--------+
                         |     uvm_env    |
                         +-------+--------+
                                 |
          +----------------------+----------------------+
          |                      |                      |
          v                      v                      v
    +-----------+           +---------+           +-----------+
    | APB Agent |           |   RAL   |           | SPI Agent |
    +-----------+           +---------+           +-----------+
          |                      |                      |
     +----+----+            Register Model        +----+----+
     |    |    |                                   |    |    |
   Seq  Drv  Mon                                Seq  Drv  Mon
     |    |    |                                   |    |    |
     +----+----+---------------+-------------------+----+----+
                                |
                         +------v-------+
                         |  Scoreboard  |
                         +------+-------+
                                |
                    +-----------+-----------+
                    |                       |
                    v                       v
             Functional Coverage       Assertions
                  (SVA/CG)
```

---

# 🧩 UVM Components

## 1. APB Agent

The APB agent handles APB transactions between the testbench and DUT.

```text
APB Agent
│
├── APB Sequencer
├── APB Driver
└── APB Monitor
```

### APB Sequencer

Generates APB sequence items for:

* Register writes
* Register reads
* Configuration transactions
* Data transactions

### APB Driver

Converts APB sequence items into pin-level APB transactions.

### APB Monitor

Observes APB bus activity and publishes transactions through an analysis port.

---

# 2. SPI Agent

The SPI agent handles SPI-side transactions.

```text
SPI Agent
│
├── SPI Sequencer
├── SPI Driver
└── SPI Monitor
```

The SPI monitor observes:

* `SCLK`
* `MOSI`
* `MISO`
* `CS_N`

---

# 3. UVM Register Abstraction Layer — RAL

The **UVM Register Abstraction Layer** is used to model the DUT registers.

```text
                    uvm_reg_block
                          |
        +-----------------+-----------------+
        |                 |                 |
        v                 v                 v
   Control Reg        Status Reg        Data Reg
        |                 |                 |
        +-----------------+-----------------+
                          |
                    APB Adapter
                          |
                    APB Sequencer
                          |
                     APB Driver
                          |
                         DUT
```

RAL provides:

* Register abstraction
* Register field modeling
* Register read/write operations
* Frontdoor register access
* Reset value checking
* Register mirror management
* Register prediction

---

# 🔄 RAL Adapter & Predictor

The APB monitor is connected to a **UVM register predictor**.

```text
                    RAL
                     |
              uvm_reg_adapter
                     |
              APB Sequencer
                     |
                APB Driver
                     |
                    DUT
                     |
                APB Monitor
                     |
              uvm_reg_predictor
                     |
                    RAL
```

The adapter converts register operations into APB transactions.

The predictor updates the RAL mirror based on observed APB transactions.

---

# 🔍 Scoreboard

The scoreboard receives transactions from the APB and SPI monitors.

```text
              APB Monitor
                   |
             analysis_port
                   |
                   v
             +-----------+
             |           |
             | Scoreboard|
             |           |
             +-----------+
                   ^
             analysis_port
                   |
              SPI Monitor
```

The scoreboard checks:

* Expected vs actual APB transactions
* Expected vs actual SPI data
* Transmitted data
* Received data
* Register-related behavior
* Transaction consistency

---

# 📈 Functional Coverage

Functional coverage is implemented using SystemVerilog covergroups.

Coverage points include:

* `CPOL`
* `CPHA`
* `LSBFE`
* SPI data
* APB read/write
* Reset
* Low-power mode
* SPI configuration combinations

### Cross Coverage

The important configuration cross is:

```text
CPOL × CPHA × LSBFE
```

This produces:

```text
2 × 2 × 2 = 8 combinations
```

All 8 combinations are targeted during verification.

---

# ✅ SystemVerilog Assertions

SystemVerilog Assertions are used to verify protocol and design-level behavior.

Assertions are used for checking:

* Reset behavior
* APB protocol behavior
* SPI clock behavior
* Chip-select behavior
* Data transfer sequencing
* Sampling conditions
* Transfer completion
* Low-power behavior
* Configuration-related conditions

Assertions provide an independent mechanism for detecting protocol and timing-related violations.

---

# 🧪 Verification Test Cases

The main verification tests are derived from the three configuration bits:

```text
CPOL
CPHA
LSBFE
```

Since each bit has two possible values:

```text
2 × 2 × 2 = 8 SPI configurations
```

In addition, **Reset** and **Low-Power** are separately verified.

Therefore, there are **10 major verification scenarios**.

---

## Test Case 1 — CPOL=0, CPHA=0, LSBFE=0

**Configuration:**

```text
CPOL  = 0
CPHA  = 0
LSBFE = 0
```

**Purpose:**

Verify SPI data transmission and reception with:

* SPI Mode 0
* MSB-first data transfer
* Normal SPI operation

---

## Test Case 2 — CPOL=0, CPHA=0, LSBFE=1

**Configuration:**

```text
CPOL  = 0
CPHA  = 0
LSBFE = 1
```

**Purpose:**

Verify:

* SPI Mode 0
* LSB-first data transfer
* Correct serial data ordering

---

## Test Case 3 — CPOL=0, CPHA=1, LSBFE=0

**Configuration:**

```text
CPOL  = 0
CPHA  = 1
LSBFE = 0
```

**Purpose:**

Verify:

* SPI Mode 1
* MSB-first transfer
* Correct clock phase and data sampling

---

## Test Case 4 — CPOL=0, CPHA=1, LSBFE=1

**Configuration:**

```text
CPOL  = 0
CPHA  = 1
LSBFE = 1
```

**Purpose:**

Verify:

* SPI Mode 1
* LSB-first transfer
* Correct clock phase
* Correct bit ordering

---

## Test Case 5 — CPOL=1, CPHA=0, LSBFE=0

**Configuration:**

```text
CPOL  = 1
CPHA  = 0
LSBFE = 0
```

**Purpose:**

Verify:

* SPI Mode 2
* MSB-first transfer
* Clock polarity behavior
* Correct data sampling

---

## Test Case 6 — CPOL=1, CPHA=0, LSBFE=1

**Configuration:**

```text
CPOL  = 1
CPHA  = 0
LSBFE = 1
```

**Purpose:**

Verify:

* SPI Mode 2
* LSB-first transfer
* Clock polarity
* Data ordering

---

## Test Case 7 — CPOL=1, CPHA=1, LSBFE=0

**Configuration:**

```text
CPOL  = 1
CPHA  = 1
LSBFE = 0
```

**Purpose:**

Verify:

* SPI Mode 3
* MSB-first transfer
* Clock phase
* Clock polarity

---

## Test Case 8 — CPOL=1, CPHA=1, LSBFE=1

**Configuration:**

```text
CPOL  = 1
CPHA  = 1
LSBFE = 1
```

**Purpose:**

Verify:

* SPI Mode 3
* LSB-first transfer
* Correct clock polarity
* Correct clock phase
* Correct serial bit ordering

---

# 🔄 Test Case 9 — Reset Test

The reset test verifies the behavior of the DUT when reset is asserted and released.

### Checks

* DUT enters the expected reset state
* Control registers are reset correctly
* Status registers return to reset values
* SPI outputs reach the expected reset state
* No invalid SPI transaction occurs during reset
* Normal operation resumes after reset release

---

# ⚡ Test Case 10 — Low-Power Test

The low-power test verifies the SPI peripheral's behavior during low-power operation.

### Checks

* DUT enters the expected low-power state
* SPI activity is appropriately controlled
* Outputs remain in the expected state
* Configuration/state is maintained or restored as specified
* Normal operation resumes after exiting low-power mode

---

# 📋 Complete Test Matrix

| Test             | CPOL | CPHA | LSBFE | SPI Mode | Bit Order |
| ---------------- | ---: | ---: | ----: | -------: | --------- |
| `spi_test_000`   |    0 |    0 |     0 |   Mode 0 | MSB       |
| `spi_test_001`   |    0 |    0 |     1 |   Mode 0 | LSB       |
| `spi_test_010`   |    0 |    1 |     0 |   Mode 1 | MSB       |
| `spi_test_011`   |    0 |    1 |     1 |   Mode 1 | LSB       |
| `spi_test_100`   |    1 |    0 |     0 |   Mode 2 | MSB       |
| `spi_test_101`   |    1 |    0 |     1 |   Mode 2 | LSB       |
| `spi_test_110`   |    1 |    1 |     0 |   Mode 3 | MSB       |
| `spi_test_111`   |    1 |    1 |     1 |   Mode 3 | LSB       |
| `reset_test`     |    — |    — |     — |        — | —         |
| `low_power_test` |    — |    — |     — |        — | —         |

---

# 🔬 Verification Flow

```text
                  TEST
                    |
                    v
                SEQUENCE
                    |
                    v
                SEQUENCER
                    |
                    v
                 DRIVER
                    |
                    v
                  DUT
              APB-SPI Master
                    |
          +---------+---------+
          |                   |
          v                   v
      APB Monitor         SPI Monitor
          |                   |
          +---------+---------+
                    |
                    v
                SCOREBOARD
                    |
          +---------+---------+
          |                   |
          v                   v
      PASS / FAIL       Functional Coverage
                              +
                         SVA Assertions
```

---

# 📁 Repository Structure

```text
APB_SPI_RTL_UVM/
│
├── rtl/
│   ├── apb_spi.sv
│   ├── spi_master.sv
│   └── ...
│
├── tb/
│   │
│   ├── interfaces/
│   │
│   ├── apb_agent/
│   │   ├── apb_xtn.sv
│   │   ├── apb_sequencer.sv
│   │   ├── apb_driver.sv
│   │   ├── apb_monitor.sv
│   │   └── apb_sequences.sv
│   │
│   ├── spi_agent/
│   │   ├── spi_xtn.sv
│   │   ├── spi_sequencer.sv
│   │   ├── spi_driver.sv
│   │   ├── spi_monitor.sv
│   │   └── spi_sequences.sv
│   │
│   ├── ral/
│   │   ├── spi_reg_model.sv
│   │   ├── spi_reg_adapter.sv
│   │   └── spi_reg_predictor.sv
│   │
│   ├── scoreboard/
│   │   └── spi_scoreboard.sv
│   │
│   ├── coverage/
│   │   └── spi_coverage.sv
│   │
│   ├── assertions/
│   │   └── spi_assertions.sv
│   │
│   ├── env/
│   │   └── spi_env.sv
│   │
│   ├── sequences/
│   │
│   └── tests/
│       ├── spi_test_000.sv
│       ├── spi_test_001.sv
│       ├── spi_test_010.sv
│       ├── spi_test_011.sv
│       ├── spi_test_100.sv
│       ├── spi_test_101.sv
│       ├── spi_test_110.sv
│       ├── spi_test_111.sv
│       ├── reset_test.sv
│       └── low_power_test.sv
│
├── docs/
│   └── apb_spi_uvm_architecture.png
│
├── sim/
│   └── run.do
│
├── waves/
│
└── README.md
```

*Update the filenames and directories to match the actual repository.*

---

# 🛠️ Tools & Technologies

| Category              | Technology               |
| --------------------- | ------------------------ |
| RTL Design            | Verilog / SystemVerilog  |
| Verification          | SystemVerilog / UVM      |
| Register Verification | UVM RAL                  |
| Bus Protocol          | AMBA APB                 |
| Serial Protocol       | SPI                      |
| Assertions            | SystemVerilog Assertions |
| Coverage              | Functional Coverage      |
| Simulation            | ModelSim / VCS           |
| Waveform Debug        | ModelSim / GTKWave       |
| Version Control       | Git / GitHub             |

---

# ▶️ Simulation

## ModelSim

Example compilation flow:

```bash
vlog -sv rtl/*.sv
vlog -sv tb/*.sv
vsim -voptargs=+acc work.base_test
run -all
```

The exact commands depend on the repository structure.

## VCS

Example:

```bash
vcs -sverilog -ntb_opts uvm rtl/*.sv tb/*.sv
./simv
```

---

# 📊 Verification Goals

The verification environment targets:

* All **8 CPOL/CPHA/LSBFE combinations**
* Reset behavior
* Low-power behavior
* APB register access
* SPI data transfer
* MSB-first operation
* LSB-first operation
* SPI clock behavior
* Register model behavior
* Scoreboard checking
* Functional coverage
* SVA-based protocol checking

---

# 🎓 Key Skills Demonstrated

This project demonstrates practical experience in:

* RTL design
* APB protocol
* SPI protocol
* FSM-based design
* Register-based peripheral design
* SystemVerilog
* UVM
* UVM RAL
* Register Adapter
* Register Predictor
* APB Agent
* SPI Agent
* Sequencer / Driver / Monitor
* Scoreboard
* Constrained-random verification
* Functional coverage
* Cross coverage
* SystemVerilog Assertions
* Reset verification
* Low-power verification
* Waveform debugging
* Git and GitHub

---

# 👩‍💻 Author

## Jahnavi Reddy Saddala

**B.Tech – Electrical and Electronics Engineering**

**Focus:** VLSI Design & Design Verification

### Skills Demonstrated

`Verilog` · `SystemVerilog` · `UVM` · `UVM RAL` · `APB` · `SPI` · `SVA` · `Functional Coverage` · `Constrained Randomization` · `Scoreboard` · `RTL Verification`

---

# ⭐ Project Summary

### APB-Interfaced SPI Master — RTL Design & UVM Verification

A complete front-end VLSI verification project covering:

**RTL Design → APB Interface → Register Model → SPI Communication → UVM Environment → RAL → Scoreboard → Assertions → Functional Coverage → Reset → Low-Power Verification → Simulation & Debugging**
