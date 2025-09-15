# Flow Report Summary

## Anotações
- Cuidado ao compilar o projeto, talvez não sejam necessárias todas as etapas no painel Task principal. Para o RTL Viewer, por exemplo, precisa somente da análise e síntese. 
- ``Tools > Reports > Compilation Report/Flow Report``

## Flow Summary
- **Flow Status**: Successful - Fri Mar 8 09:49:30 2024
- **Quartus Prime Version**: 20.1.1 Build 720 11/11/2020 SJ Standard Edition
- **Revision Name**: hamming_distance
- **Top-level Entity Name**: hamming_distance
- **Family**: Cyclone IV E
- **Device**: EP4CE6E22C7

## Flow Settings
- **Start date & time**: 03/08/2024 09:48:59
- **Main task**: Compilation

## Flow Non-Default Global Settings
- **EDA Simulation Tool**: ModelSim-Altera (VHDL)
- **Power Preset Cooling Solution**: 23 MM HEAT SINK WITH 200 LFPM AIRFLOW
- **Project Output Directory**: output_files

## Flow Elapsed Time
| Module Name         | Elapsed Time | Average Processors Used | Peak Virtual Memory | Total CPU Time (on all processors) |
|---------------------|--------------|-------------------------|---------------------|------------------------------------|
| Analysis & Synthesis| 00:00:08     | 1.0                     | 456 MB              | 00:00:21                           |
| Fitter              | 00:00:04     | 1.0                     | 1245 MB             | 00:00:04                           |
| Assembler           | 00:00:01     | 1.0                     | 345 MB              | 00:00:01                           |
| Timing Analyzer     | 00:00:01     | 1.0                     | 492 MB              | 00:00:01                           |
| EDA Netlist Writer  | 00:00:02     | 1.0                     | 590 MB              | 00:00:00                           |
| Total               | 00:00:16     | --                      | --                  | 00:00:27                           |

## Flow OS Summary
| Module Name         | Machine Hostname    | OS Name           | OS Version | Processor type |
|---------------------|---------------------|-------------------|------------|----------------|
| Analysis & Synthesis| TELE-Matlab-Quartus| Debian GNU/Linux  | 10         | x86_64         |
| Fitter              | TELE-Matlab-Quartus| Debian GNU/Linux  | 10         | x86_64         |
| Assembler           | TELE-Matlab-Quartus| Debian GNU/Linux  | 10         | x86_64         |
| Timing Analyzer     | TELE-Matlab-Quartus| Debian GNU/Linux  | 10         | x86_64         |
| EDA Netlist Writer  | TELE-Matlab-Quartus| Debian GNU/Linux  | 10         | x86_64         |

## Flow Log
- quartus_map, quartus_fit, quartus_asm, quartus_sta, quartus_eda commands were executed.

## Critical Warnings
1. **No exact pin location assignment(s) for 14 pins of 14 total pins.**
2. **Synopsys Design Constraints File file not found: 'Ckt74161.sdc'.** A Synopsys Design Constraints File is required for proper timing constraints.

