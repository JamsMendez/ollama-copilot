SERVICE_TEMPLATE=ollama-copilot.service.tmpl

build:
	go build -o ollama-copilot main.go

install:
	mv ollama-copilot /usr/local/bin

enable-systemd: $(SERVICE_TEMPLATE)
	@echo "Create unit sytemd file"
	@sed "s/{{USER}}/$(USER)/g" $(SERVICE_TEMPLATE) > ollama-copilot.service
	@cp ollama-copilot.service /etc/systemd/system/ollama-copilot.service
	@rm ollama-copilot.service
	@echo "Move unit sytemd file to /etc/systemd/system"
	@systemctl daemon-reload
	@systemctl enable ollama-copilot.service
	@systemctl start ollama-copilot.service
	@echo "Enable unit sytemd file to start on boot"

status-systemd:
	systemctl status ollama-copilot.service

health-check:
	curl -s http://localhost:11437/health

.PHONY: build install enable-systemd status-systemd health-check