SERVICE_TEMPLATE=linux/ollama-copilot.service.tmpl
UNIT_SYSTEM_FILE=linux/ollama-copilot.service

build:
	go build -o ollama-copilot main.go

bin:
	mv ollama-copilot /usr/local/bin

enable-systemd: $(SERVICE_TEMPLATE)
	@echo "Create unit sytemd file"
	@sed "s/{{USER}}/$(USER)/g" $(SERVICE_TEMPLATE) > $(UNIT_SYSTEM_FILE)
	@cp  $(UNIT_SYSTEM_FILE) /etc/systemd/system/ollama-copilot.service
	@rm $(UNIT_SYSTEM_FILE)
	@echo "Move unit sytemd file to /etc/systemd/system"
	@systemctl daemon-reload
	@systemctl enable ollama-copilot.service
	@systemctl start ollama-copilot.service
	@echo "Enable unit sytemd file to start on boot"

status-systemd:
	systemctl status ollama-copilot.service

health-check:
	curl -s http://localhost:11437/health

install: build bin enable-systemd status-systemd health-check

.PHONY: install
