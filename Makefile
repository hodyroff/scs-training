#!/usr/bin/make
# 
# Create PDF for training material using pandoc
#
# (c) Kurt Garloff <s7n@garloff.de>, 6.2025
# SPDX-License-Identifier: CC-BY-SA-4.0

INPUTS = Virtualization/README.md \
	 clusterstacks/cluster-stacks.md \
	 monitoring/monitoring.md \
	 registry/registry.md

VIRTINPUTS = Virtualization/Front.md \
	Virtualization/Virt-Architecture.md \
	Virtualization/Kolla-OSISM.md \
	Virtualization/Ceph-Knowledge.md \
	Virtualization/OSISM-Admin.md \
	Virtualization/Perf-Compl-Monitoring.md \
	Virtualization/Environments.md \
	Virtualization/Maintenance.md \
	Virtualization/Updates.md \
	Virtualization/Support.md

ALLINPUTS = Header.md \
	 $(VIRTINPUTS) \
	 clusterstacks/cluster-stacks.md \
	 monitoring/monitoring.md \
	 registry/registry.md

SEARCHDIRS = Virtualization:clusterstacks:monitoring:registry

TARGET = SCS-Training.pdf
TFONT = tgschola
TARGETLUA = SCS-Training-Sans.pdf
LFONT = "Lato"

default: $(TARGET)
sans: $(TARGETLUA)
all: default sans

$(TARGET): $(ALLINPUTS) Makefile
	pandoc -V geometry:a4paper,margin=24mm -V fontfamily=$(TFONT) --resource-path=$(SEARCHDIRS) -r markdown -w pdf -o $@ $(ALLINPUTS)

$(TARGETLUA): $(ALLINPUTS) Makefile
	pandoc -V geometry:a4paper,margin=24mm -V mainfont="$(LFONT)" --pdf-engine=lualatex --resource-path=$(SEARCHDIRS) -r markdown -w pdf -o $@ $(ALLINPUTS)

clean:
	rm -f $(TARGET) $(TARGETLUA)
