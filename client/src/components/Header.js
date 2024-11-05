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
<<<<<<< HEAD
          color={showAdd ? "gray" : "green"}
=======
          color={showAdd ? "red" : "purple"}
>>>>>>> main
          text={showAdd ? "Fechar" : "Adicionar"}
          onClick={onAdd}
        />
      )}
    </header>
  );
};

Header.defaultProps = {
<<<<<<< HEAD
  title: "Meddiflux",
=======
  title: "MEDDIFLUX",
>>>>>>> main
};

export default Header;
