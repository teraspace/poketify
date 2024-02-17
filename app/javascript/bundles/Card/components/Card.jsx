import PropTypes from 'prop-types';
import React, { useState } from 'react';
import style from './Card.module.css';

const Card = (props) => {
  return (
    <div class="card d-flex container mt-1" style={{border: "none", width: "19rem"}}>
        <div class="card p-1 bg-white"><i class="fa fa-apple"></i>
            <div class="about-product text-center mt-1">
                <img src={props.photo} width="150" />
                <div class="row">
                    <h4>{props.pokemon.name}</h4>
                </div>
                <div class="">
                  <span className={"badge " + props.type["class"]} >
                    {props.type["name"][0]}
                  </span>
                </div>
            </div>
            <br />
            <div class="row text-center">
                <div class="stats mt-1" style={{maxWidth: "6rem"}}>
                    <div>
                        <h3>{props.weight}</h3>
                        <p>Weight</p>
                    </div>
                </div>
                <div class="stats mt-1" style={{maxWidth: "6rem"}}>
                    <div>
                        <h3>{props.base_experience}</h3>
                        <p>Exp</p>
                    </div>
                </div>
                <div class="stats mt-1" style={{maxWidth: "6rem"}}>
                    <div>
                        <h3>{props.height}</h3>
                        <p>Height</p>
                    </div>
                </div>
                <div class="stats mt-1">
                    <h5>Abilities:</h5>
                    <p>
                      {props.abilities}
                    </p>
                </div>
                {props.evolutions && <div class="stats mt-1">
                  <h5>Evolves To</h5>
                  <span>
                      {props.evolutions[1]["name"]}
                  </span>
                </div>}
            </div>

        </div>
        <br/>
        {props.description && <div class="container-fluid">
          <div class="row">
            <h2>
                Description
            </h2>
            <p class="text-left">{props.description}</p>
          </div>
        </div>}
    </div>
  );
};

export default Card;
