import unittest
from flask import Flask, jsonify, request
from flask_cors import CORS
from flask.testing import FlaskClient
from flask_mysqldb import MySQL
from unittest.mock import MagicMock, patch

from app.py import app

class AppTestCase(unittest.TestCase):
    def setUp(self):
        self.app = app.test_client()

    def test_get_cuenta(self):
        with app.test_request_context('/api/get-cuenta/', method='POST', json={"cedula": "1723226443"}):
            with patch("banco.sql") as mock_mysql:
                mock_cursor = MagicMock()
                mock_cursor.fetchall.return_value = [("Karla", "Cusme", "Karcus@example.com", "1723226443", "123", "Ahorros", 100.00)]
                mock_mysql.connection.cursor.return_value = mock_cursor

                response = self.app.post('/api/get-cuenta/')
                data = response.get_json()

                # Asegúrate de que el método de conexión a MySQL se haya llamado
                mock_mysql.connection.cursor.assert_called()

                # Aquí puedes realizar aserciones para verificar el comportamiento esperado
                self.assertEqual(response.status_code, 200)
                self.assertEqual(data, [("Daniela", "Sosa", "daniela@example.com", "1234567890", "123", "Ahorros", 100.00)])

    def test_set_cuenta(self):
        with app.test_request_context('/api/set-cuenta/', method='POST', json={"cedula": "1723226443", "nombres": "Karla", "apellidos": "Cusme", "email": "Karcus@example.com", "direccion": "123", "telefono": "1234567890", "tipo": "Ahorros"}):
            with patch("banco.sql") as mock_mysql:
                mock_cursor = MagicMock()
                mock_cursor.fetchall.return_value = []
                mock_mysql.connection.cursor.return_value = mock_cursor

                response = self.app.post('/api/set-cuenta/')
                data = response.get_data(as_text=True)

                # Asegúrate de que el método de conexión a MySQL se haya llamado
                mock_mysql.connection.cursor.assert_called()

                # Aquí puedes realizar aserciones para verificar el comportamiento esperado
                self.assertEqual(response.status_code, 200)
                self.assertEqual(data, "Cuenta creada")

    def test_transacciones(self):
        with app.test_request_context('/api/transacciones/', method='POST', json={"num_cuenta_ori": "123", "num_cuenta_dest": "456", "monto": 100.00, "fecha": "2023-12-18"}):
            with patch("banco.sql") as mock_mysql:
                mock_cursor = MagicMock()
                mock_cursor.fetchall.return_value = [(200.00,)]
                mock_mysql.connection.cursor.return_value = mock_cursor

                response = self.app.post('/api/transacciones/')
                data = response.get_data(as_text=True)

                # Asegúrate de que el método de conexión a MySQL se haya llamado
                mock_mysql.connection.cursor.assert_called()

                # Aquí puedes realizar aserciones para verificar el comportamiento esperado
                self.assertEqual(response.status_code, 200)
                self.assertEqual(data, "Realizada")

    def test_solicitudes(self):
        with app.test_request_context('/api/solicitudes/', method='POST', json={"cedula": "1234567890", "nombres": "Daniela", "apellidos": "Sosa", "email": "daniela@example.com", "telefono": "1234567890", "monto": 1000.00, "uso": "Personal", "tasa": 5.0}):
            with patch("banco.sql") as mock_mysql:
                mock_cursor = MagicMock()
                mock_mysql.connection.cursor.return_value = mock_cursor

                response = self.app.post('/api/solicitudes/')
                data = response.get_data(as_text=True)

                # Asegúrate de que el método de conexión a MySQL se haya llamado
                mock_mysql.connection.cursor.assert_called()

                # Aquí puedes realizar aserciones para verificar el comportamiento esperado
                self.assertEqual(response.status_code, 200)
                self.assertEqual(data, "Guardado")

if __name__ == '__main__':
    unittest.main()