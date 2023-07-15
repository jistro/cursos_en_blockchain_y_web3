import React from "react"

export default function App() {
    const [formData, setFormData] = React.useState(
        { 
          firstName: "", 
          lastName: "", 
          email: "", 
          comments: "",
          commitsTaxFroud: false,
          enmploymentStatus: "",
          country: ""
        }
    )

    const dataSubmited = {
          firstName: "", 
          lastName: "", 
          email: "", 
          comments: "",
          commitsTaxFroud: false,
          enmploymentStatus: "",
          country: ""
    }
    
    function handleChange(event) {
      const{name, value, type, checked} = event.target
        setFormData(prevFormData => {
            return {
                ...prevFormData,
                //[name]: value
                [name]: type === "checkbox" ? checked : value
            }
        })
    }

    function handleSubmit(event) {
        event.preventDefault()
        console.log(formData)
    }
    
    return (
      <div>
        <form>
            <input
                type="text"
                placeholder="First Name"
                onChange={handleChange}
                name="firstName"
                value={formData.firstName}
                className="form--input"
            />
            <input
                type="text"
                placeholder="Last Name"
                onChange={handleChange}
                name="lastName"
                value={formData.lastName}
                className="form--input"
            />
            <input
                type="email"
                placeholder="Email"
                onChange={handleChange}
                name="email"
                value={formData.email}
                className="form--input"
            />
            <textarea
              placeholder="Comments"
              onChange={handleChange}
              name="comments"
              vale={formData.comments}
              className="form--input"
            />
            <label htmlFor="commitsTaxFroud">
              <input 
                  type="checkbox" 
                  id="commitsTaxFroud"
                  checked={formData.commitsTaxFroud}
                  onChange={handleChange}
                  name="commitsTaxFroud"
                  className="checkbox--container"
              />
              Commits Tax Froud?
            </label>
            <fieldset>
                <legend>Current employment status</legend>
                <label htmlFor="unemployed">
                  <input 
                      type="radio"
                      id="unemployed"
                      name="enmploymentStatus"
                      value="unemployed"
                      checked={formData.enmploymentStatus === "unemployed"}
                      onChange={handleChange}
                  />
                Unemployed</label>
                <br />

                <label htmlFor="part-time">
                  <input 
                      type="radio"
                      id="part-time"
                      name="enmploymentStatus"
                      value="part-time"
                      checked={formData.enmploymentStatus === "part-time"}
                      onChange={handleChange}
                  />
                Part-time</label>
                <br />
                <label htmlFor="full-time">
                  <input 
                      type="radio"
                      id="full-time"
                      name="enmploymentStatus"
                      value="full-time"
                      checked={formData.enmploymentStatus === "full-time"}
                      onChange={handleChange}
                  />
                Full-time</label>
                <br />
            </fieldset>
            <label htmlFor="country">What country do you live in?</label>
                <select
                  id="country"
                  name="country"
                  value={formData.country}
                  onChange={handleChange}
                >
                  <option value="">--</option>
                  <option value="Brazil">Brazil</option>
                  <option value="Argentina">Argentina</option>
                  <option value="Chile">Chile</option>
                  <option value="Uruguay">Uruguay</option>
                  <option value="Mexico">Mexico</option>
                </select>
                <div>
            <fieldset>
            <legend><h2>Entered information:</h2></legend>
              <p>Your name: {formData.firstName} {formData.lastName}</p>
              <p>Your email: {formData.email}</p>
              <p>Comments: {formData.comments}</p>
              <p>Commits Tax Froud: {formData.commitsTaxFroud ? "Yes" : "No"}</p>
              <p>Current employment status: {formData.enmploymentStatus}</p>
              <p>Country: {formData.country}</p>
            </fieldset>
            </div>
            <button className="submit--button">Submit 📨</button>
        </form>
      </div>
    )
}
