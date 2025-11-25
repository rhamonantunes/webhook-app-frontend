import React, { useEffect, useState } from "react";
import ReactDOM from "react-dom/client";
import { API_URL } from "./config";

function App() {
  const [eventos, setEventos] = useState([]);

  useEffect(() => {
    const fetchEvents = async () => {
      try {
        const res = await fetch(`${API_URL}/events`);
        const data = await res.json();
        setEventos(data);   // ✅ Correção aqui
      } catch (err) {
        console.error("Erro ao buscar eventos:", err);
      }
    };

    fetchEvents();
  }, []);

  return (
    <div style={{ padding: "20px" }}>
      <h1>Eventos Recebidos</h1>
      {eventos.length === 0 && <p>Nenhum evento recebido ainda.</p>}
      <ul>
        {eventos.map((e, i) => (
          <li key={i}><pre>{JSON.stringify(e, null, 2)}</pre></li>
        ))}
      </ul>
    </div>
  );
}

const root = ReactDOM.createRoot(document.getElementById("root"));
root.render(<App />);

export default App;
