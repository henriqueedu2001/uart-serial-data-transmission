import serial

# Configurar a porta serial (substitua '/dev/ttyUSB0' pelo seu dispositivo serial)
serial_port = serial.Serial('/dev/ttyUSB0', baudrate=9600, timeout=1)

try:
    while True:
        # Ler 1 byte (8 bits) da porta serial
        byte_received = serial_port.read(1)
        
        if byte_received:
            # Exibir o byte recebido
            print("Byte recebido:", byte_received.hex())  # Exibe o byte como hexadecimal
except KeyboardInterrupt:
    # Se o usuário pressionar Ctrl+C, feche a porta serial e encerre o programa
    serial_port.close()
    print("Programa encerrado.")
