import React from "react";
import { useLocation } from "react-router-dom";
import Button from "./Button";

const Header = ({ title, onAdd, showAdd }) => {
  const location = useLocation();
  return (
    <header className="header">
      <h1>{title}</h1>
      {/* <h3>process.env.EMAIL_ALUNO</h3> */}
      {location.pathname === "/" && (
        <Button
          color={showAdd ? "Gray" : "purple"}
          text={showAdd ? "Fechar" : "Adicionar"}
          onClick={onAdd}
        />
      )}
    </header>
  );
};

Header.defaultProps = {
<<<<<<< HEAD
  title: "MEDDIFLUX + DISGRAMA DO BANCO NOVO",
=======
  title: "MEDDIFLUX + BANCO",
>>>>>>> 1acd686 (alterando arquivos do repositorio para push corretamente tentativa1)
};

export default Header;
