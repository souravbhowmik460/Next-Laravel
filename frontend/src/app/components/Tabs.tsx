export default function Tabs({tabs,active,onChange}:{tabs:string[],active:string,onChange:(tab:string)=>void}) {
  return (
    <div className="tabs">
      {tabs.map(t=>(
        <button key={t} onClick={()=>onChange(t)} className={active===t ? "active" : ""}>
          {t}
        </button>
      ))}
    </div>
  );
}
