import React from "react";

export default function Chapters(props) {
  const { id, data } = props.props;

  const printCard = (d) => {
    console.log(d.clubs);
    <div className="">{d.clubs}</div>;
  };

  return data.map((d) => {
    if (d.id === id) {
      return printCard(d);
    }
  });
}
