% ===== KOA Combined Output | contract_id: contrato_ocs_050_2021 =====

% ===== 1) UFO Ontology =====
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SERVICE CONTRACT ONTOLOGY EM PROLOG
% Inspirada em UFO-L + UFO-S + Service Contract Ontology (Griffo et al., 2017)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% META-ESTRUTURA (TBox: classes, especializações, relações entre classes)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Predicados básicos de metamodelo
class(C).          % C é uma classe ontológica
subclass_of(C, P). % C é subclasse de P
disjoint(C1, C2).  % C1 e C2 são disjuntas conceitualmente

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Núcleo UFO-A / UFO-C simplificado
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class(agent).           % agente (pessoa, organização etc.)
class(relator).         % relator genérico
class(moment).          % propriedade/momento (trope no sentido do UFO)

class(social_relator).
class(legal_relator).

subclass_of(social_relator, relator).
subclass_of(legal_relator, social_relator).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LEGAL MOMENTS E LEGAL RELATORS (UFO-L)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class(legal_moment).
class(legal_entitlement).      % vantagens jurídicas
class(legal_burden_or_lack).  % ônus / falta de prerrogativa

subclass_of(legal_entitlement, legal_moment).
subclass_of(legal_burden_or_lack, legal_moment).

% Tipos de legal relators
class(simple_legal_relator).
class(complex_legal_relator).

subclass_of(simple_legal_relator, legal_relator).
subclass_of(complex_legal_relator, legal_relator).

% ---------------------------------------------------------------------------
% Right / Duty
% ---------------------------------------------------------------------------

class(right).
class(right_to_action).
class(right_to_omission).

class(duty).
class(duty_to_act).
class(duty_to_omit).

subclass_of(right, legal_entitlement).
subclass_of(right_to_action, right).
subclass_of(right_to_omission, right).

subclass_of(duty, legal_burden_or_lack).
subclass_of(duty_to_act, duty).
subclass_of(duty_to_omit, duty).

% ---------------------------------------------------------------------------
% NoRight / Permission
% ---------------------------------------------------------------------------

class(no_right).
class(no_right_to_action).
class(no_right_to_omission).

class(permission).
class(permission_to_act).
class(permission_to_omit).

subclass_of(no_right, legal_burden_or_lack).
subclass_of(no_right_to_action, no_right).
subclass_of(no_right_to_omission, no_right).

subclass_of(permission, legal_entitlement).
subclass_of(permission_to_act, permission).
subclass_of(permission_to_omit, permission).

% ---------------------------------------------------------------------------
% Power / Subjection (Liability)
% ---------------------------------------------------------------------------

class(power).
class(subjection).

subclass_of(power, legal_entitlement).
subclass_of(subjection, legal_burden_or_lack).

% ---------------------------------------------------------------------------
% Disability / Immunity
% ---------------------------------------------------------------------------

class(disability).
class(immunity).

subclass_of(disability, legal_burden_or_lack).
subclass_of(immunity, legal_entitlement).

% ---------------------------------------------------------------------------
% Liberty (liberdade desprotegida como complex legal relator)
% ---------------------------------------------------------------------------

class(liberty_relator).
subclass_of(liberty_relator, complex_legal_relator).

% ---------------------------------------------------------------------------
% Tipos de Simple Legal Relator (pares correlatos)
% ---------------------------------------------------------------------------

class(right_duty_relator).
class(noright_permission_relator).
class(power_subjection_relator).
class(disability_immunity_relator).

subclass_of(right_duty_relator, simple_legal_relator).
subclass_of(noright_permission_relator, simple_legal_relator).
subclass_of(power_subjection_relator, simple_legal_relator).
subclass_of(disability_immunity_relator, simple_legal_relator).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CORRELAÇÃO ENTRE LEGAL MOMENTS (Hohfeld + Alexy)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Correlatos em nível de classe
correlates(right_to_action,   duty_to_act).
correlates(duty_to_act,       right_to_action).

correlates(right_to_omission, duty_to_omit).
correlates(duty_to_omit,      right_to_omission).

correlates(permission_to_act,     no_right_to_action).
correlates(no_right_to_action,    permission_to_act).

correlates(permission_to_omit,    no_right_to_omission).
correlates(no_right_to_omission,  permission_to_omit).

correlates(power,      subjection).
correlates(subjection, power).

correlates(disability, immunity).
correlates(immunity,   disability).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SERVICE RELATIONS E SERVICE CONTRACTS (núcleo UFO-S simplificado)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class(service_relation).
class(service_agreement).
class(legal_service_agreement).

subclass_of(service_agreement, service_relation).
subclass_of(legal_service_agreement, service_agreement).

% Papéis em relações de serviço
class(service_provider_role).
class(target_customer_role).
class(hired_service_provider_role).
class(service_customer_role).

subclass_of(hired_service_provider_role, service_provider_role).
subclass_of(service_customer_role,       target_customer_role).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SERVICE CONTRACT ONTOLOGY (Fig. 4 do artigo)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Em um Legal Service Agreement, cada parte tem Entitlements e Burdens/Lacks
class(hsp_entitlement).      % Hired Service Provider Entitlement
class(hsp_burden_or_lack).   % Hired Service Provider Burden/Lack
class(sc_entitlement).       % Service Customer Entitlement
class(sc_burden_or_lack).    % Service Customer Burden/Lack

subclass_of(hsp_entitlement, legal_entitlement).
subclass_of(sc_entitlement,  legal_entitlement).

subclass_of(hsp_burden_or_lack, legal_burden_or_lack).
subclass_of(sc_burden_or_lack,  legal_burden_or_lack).

% Composição: um Legal Service Agreement é composto de legal moments
% associados a cada papel (provider x customer).
relator_component(legal_service_agreement, hsp_entitlement).
relator_component(legal_service_agreement, hsp_burden_or_lack).
relator_component(legal_service_agreement, sc_entitlement).
relator_component(legal_service_agreement, sc_burden_or_lack).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ESQUEMA PARA INSTÂNCIAS (ABox): AGENTES, ACORDOS, CLÁUSULAS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% instance_of(Instancia, Classe).
% Você vai usar isso para criar indivíduos (contratos, cláusulas, agentes...).

:- dynamic instance_of/2.
:- dynamic plays_role/3.
:- dynamic legal_relation_instance/4.
:- dynamic clause_of/2.

% plays_role(Agente, Papel, Acordo).
% Ex.: plays_role(aws, hired_service_provider_role, aws_sns_agreement).
%      plays_role(cliente_x, service_customer_role, aws_sns_agreement).
plays_role(Agent, Role, Agreement).

% clause_of(ClauseId, Agreement).
% ClauseId é uma cláusula (ou grupo de cláusulas) de um acordo específico.
clause_of(ClauseId, Agreement).

% legal_relation_instance(ClauseId, LegalMoment, Bearer, Action).
%
% ClauseId   - identificador da cláusula
% LegalMoment- classe do momento jurídico (duty_to_omit, power, immunity...)
% Bearer     - quem tem esse momento (agente ou papel)
% Action     - ação/omissão ou descrição da conduta
%
% Exemplos (para você popular depois, inspirados no artigo):
% legal_relation_instance(clause_17_1, duty_to_omit, customer, share_service_with_third_parties).
% legal_relation_instance(clause_17_1, right_to_omission, provider, share_service_with_third_parties).

legal_relation_instance(ClauseId, LegalMomentClass, Bearer, Action) :-
    clause_of(ClauseId, _Agreement),
    class(LegalMomentClass),
    (   atom(Bearer)
    ;   plays_role(Bearer, _, _)
    ),
    atom(Action).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% REGRAS AUXILIARES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% fecho transitivo de subclass_of/2
subclass_of_trans(C, P) :-
    subclass_of(C, P).
subclass_of_trans(C, P) :-
    subclass_of(C, X),
    subclass_of_trans(X, P).

% is_a(Inst, Classe) — verifica se Inst é instância (direta ou indireta) de Classe
is_a(Inst, Classe) :-
    instance_of(Inst, C0),
    (   C0 = Classe
    ;   subclass_of_trans(C0, Classe)
    ).

% um legal_moment é um entitlement se a classe dele cai abaixo de legal_entitlement
is_entitlement(Inst) :-
    instance_of(Inst, C),
    subclass_of_trans(C, legal_entitlement).

% um legal_moment é um burden/lack se cai abaixo de legal_burden_or_lack
is_burden_or_lack(Inst) :-
    instance_of(Inst, C),
    subclass_of_trans(C, legal_burden_or_lack).

% Dado um LegalMomentClass, encontrar seu correlato (em termos de classe)
correlative_class(LMClass, CorrelateClass) :-
    correlates(LMClass, CorrelateClass).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FIM DA ONTOLOGIA BASE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ===== 2) Generated UFO ABox =====
% UFO-only grounding generated from: KOA_Contrato_OCS_050_2021_-_IBM_Connect_Direct_Ortec.pl
% contract_id: contrato_ocs_050_2021

instance_of(contrato_ocs_050_2021, legal_service_agreement).

instance_of(banco_nacional_de_desenvolvimento_economico_e_social_bndes, agent).
instance_of(ortec_participacoes_empresariais_ltda, agent).

plays_role(banco_nacional_de_desenvolvimento_economico_e_social_bndes, service_customer_role, contrato_ocs_050_2021).
plays_role(ortec_participacoes_empresariais_ltda, hired_service_provider_role, contrato_ocs_050_2021).

clause_of(clausula_primeira_objeto, contrato_ocs_050_2021).
clause_of(clausula_segunda_vigencia, contrato_ocs_050_2021).
clause_of(clausula_terceira_local_prazo_condicoes_execucao_objeto, contrato_ocs_050_2021).
clause_of(clausula_quarta_niveis_servico, contrato_ocs_050_2021).
clause_of(clausula_quinta_recebimento_objeto, contrato_ocs_050_2021).
clause_of(clausula_sexta_preco, contrato_ocs_050_2021).
clause_of(clausula_setima_pagamento, contrato_ocs_050_2021).
clause_of(clausula_oitava_equilibrio_economico_financeiro_contrato, contrato_ocs_050_2021).
clause_of(clausula_decima_obrigações_contratado, contrato_ocs_050_2021).
clause_of(clausula_decima_primeira_conduta_ética_do_contratado_e_do_bndes, contrato_ocs_050_2021).
clause_of(clausula_decima_segunda_sigilo_das_informações, contrato_ocs_050_2021).
clause_of(clausula_decima_terceira_obrigações_contratante, contrato_ocs_050_2021).
clause_of(clausula_decima_quarta_cessão_contrato_credito_sucessão_subcontratação, contrato_ocs_050_2021).
clause_of(clausula_decima_quinta_penalidades, contrato_ocs_050_2021).
clause_of(clausula_decima_sexta_alterações_contratuais, contrato_ocs_050_2021).
clause_of(clausula_decima_setima_extinção_contrato, contrato_ocs_050_2021).
clause_of(clausula_decima_oitava_disposições_finais, contrato_ocs_050_2021).
clause_of(clausula_decima_nona_foro, contrato_ocs_050_2021).
clause_of(clausula_nona_matriz_riscos, contrato_ocs_050_2021).

legal_relation_instance(clausula_primeira_objeto, duty_to_act, ortec_participacoes_empresariais_ltda, provide_technical_support_and_software_update).
legal_relation_instance(clausula_primeira_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_technical_support_and_software_update).
legal_relation_instance(clausula_segunda_vigencia, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, maintain_contract_for_60_months).
legal_relation_instance(clausula_segunda_vigencia, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, enforce_contract_for_60_months).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, duty_to_act, ortec_participacoes_empresariais_ltda, execute_contract_object).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, expect_execution_according_specifications).
legal_relation_instance(clausula_quarta_niveis_servico, duty_to_act, ortec_participacoes_empresariais_ltda, execute_services_according_to_standards).
legal_relation_instance(clausula_quarta_niveis_servico, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_price_reduction_index).
legal_relation_instance(clausula_quarta_niveis_servico, subjection, ortec_participacoes_empresariais_ltda, be_subject_to_price_reduction_index).
legal_relation_instance(clausula_quarta_niveis_servico, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, demand_services_executed_according_to_standards).
legal_relation_instance(clausula_quinta_recebimento_objeto, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_object).
legal_relation_instance(clausula_quinta_recebimento_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, right_to_receive_object).
legal_relation_instance(clausula_quinta_recebimento_objeto, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, power_to_receive_object).
legal_relation_instance(clausula_sexta_preco, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, pay).
legal_relation_instance(clausula_sexta_preco, right_to_action, ortec_participacoes_empresariais_ltda, receive_payment).
legal_relation_instance(clausula_sexta_preco, duty_to_act, ortec_participacoes_empresariais_ltda, complement_quantities).
legal_relation_instance(clausula_sexta_preco, subjection, ortec_participacoes_empresariais_ltda, accept_price_reduction).
legal_relation_instance(clausula_sexta_preco, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, partially_execute_receive).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, effectuar_pagamento).
legal_relation_instance(clausula_setima_pagamento, right_to_action, ortec_participacoes_empresariais_ltda, receive_payment).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, ortec_participacoes_empresariais_ltda, apresentar_documento_fiscal).
legal_relation_instance(clausula_setima_pagamento, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_fiscal_document).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, ortec_participacoes_empresariais_ltda, encaminhar_documento_fiscal_por_email).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, ortec_participacoes_empresariais_ltda, emitir_documento_fiscal_em_conformidade_com_legislacao).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, pagar_juros_de_mora).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, request_economic_financial_equilibrium).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, ortec_participacoes_empresariais_ltda, request_price_readjustment).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, ortec_participacoes_empresariais_ltda, request_price_revision).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, ortec_participacoes_empresariais_ltda, present_supporting_documents_revision).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, ortec_participacoes_empresariais_ltda, request_price_adjustment_before_contract_end).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, no_right_to_action, ortec_participacoes_empresariais_ltda, request_price_adjustment_after_deadline).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, analyze_readjustment_request).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, ortec_participacoes_empresariais_ltda, present_information_for_price_reduction).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, permission_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, suspend_analysis_readjustment_request).
legal_relation_instance(clausula_decima_obrigações_contratado, duty_to_act, ortec_participacoes_empresariais_ltda, maintain_conditions).
legal_relation_instance(clausula_decima_obrigações_contratado, duty_to_act, ortec_participacoes_empresariais_ltda, communicate_penalty).
legal_relation_instance(clausula_decima_obrigações_contratado, duty_to_act, ortec_participacoes_empresariais_ltda, repair_object).
legal_relation_instance(clausula_decima_obrigações_contratado, duty_to_act, ortec_participacoes_empresariais_ltda, repair_damages).
legal_relation_instance(clausula_decima_obrigações_contratado, duty_to_act, ortec_participacoes_empresariais_ltda, pay_taxes).
legal_relation_instance(clausula_decima_obrigações_contratado, duty_to_act, ortec_participacoes_empresariais_ltda, providenciar_exclusao).
legal_relation_instance(clausula_decima_obrigações_contratado, duty_to_act, ortec_participacoes_empresariais_ltda, permit_inspections).
legal_relation_instance(clausula_decima_obrigações_contratado, duty_to_act, ortec_participacoes_empresariais_ltda, obey_instructions).
legal_relation_instance(clausula_decima_obrigações_contratado, duty_to_act, ortec_participacoes_empresariais_ltda, designate_representative).
legal_relation_instance(clausula_decima_obrigações_contratado, duty_to_act, ortec_participacoes_empresariais_ltda, permit_access_banco_central).
legal_relation_instance(clausula_decima_primeira_conduta_ética_do_contratado_e_do_bndes, duty_to_omit, ortec_participacoes_empresariais_ltda, omit_undue_advantage).
legal_relation_instance(clausula_decima_primeira_conduta_ética_do_contratado_e_do_bndes, duty_to_act, ortec_participacoes_empresariais_ltda, take_measures_to_prevent_corruption).
legal_relation_instance(clausula_decima_primeira_conduta_ética_do_contratado_e_do_bndes, duty_to_omit, ortec_participacoes_empresariais_ltda, omit_favoring_bndes_employees).
legal_relation_instance(clausula_decima_primeira_conduta_ética_do_contratado_e_do_bndes, duty_to_omit, ortec_participacoes_empresariais_ltda, omit_allocate_bndes_employee_family).
legal_relation_instance(clausula_decima_primeira_conduta_ética_do_contratado_e_do_bndes, duty_to_act, ortec_participacoes_empresariais_ltda, observe_bndes_code_of_ethics).
legal_relation_instance(clausula_decima_primeira_conduta_ética_do_contratado_e_do_bndes, duty_to_act, ortec_participacoes_empresariais_ltda, remove_agents).
legal_relation_instance(clausula_decima_primeira_conduta_ética_do_contratado_e_do_bndes, duty_to_act, ortec_participacoes_empresariais_ltda, communicate_to_bndes).
legal_relation_instance(clausula_decima_primeira_conduta_ética_do_contratado_e_do_bndes, duty_to_act, ortec_participacoes_empresariais_ltda, adopt_sustainable_practices).
legal_relation_instance(clausula_decima_segunda_sigilo_das_informações, duty_to_act, ortec_participacoes_empresariais_ltda, maintain_confidentiality).
legal_relation_instance(clausula_decima_segunda_sigilo_das_informações, duty_to_act, ortec_participacoes_empresariais_ltda, provide_confidentiality_agreements).
legal_relation_instance(clausula_decima_segunda_sigilo_das_informações, duty_to_act, ortec_participacoes_empresariais_ltda, orient_professionals_about_confidentiality).
legal_relation_instance(clausula_decima_segunda_sigilo_das_informações, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, request_confidentiality_agreements).
legal_relation_instance(clausula_decima_segunda_sigilo_das_informações, subjection, ortec_participacoes_empresariais_ltda, signing_confidentiality_agreements).
legal_relation_instance(clausula_decima_terceira_obrigações_contratante, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, make_payments_to_contracted_party).
legal_relation_instance(clausula_decima_terceira_obrigações_contratante, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, designate_contract_manager).
legal_relation_instance(clausula_decima_terceira_obrigações_contratante, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, designate_contract_manager_substitute).
legal_relation_instance(clausula_decima_terceira_obrigações_contratante, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, alter_contract_manager).
legal_relation_instance(clausula_decima_terceira_obrigações_contratante, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_code_of_ethics).
legal_relation_instance(clausula_decima_terceira_obrigações_contratante, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_necessary_information).
legal_relation_instance(clausula_decima_terceira_obrigações_contratante, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_instructions).
legal_relation_instance(clausula_decima_terceira_obrigações_contratante, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_administrative_procedure).
legal_relation_instance(clausula_decima_terceira_obrigações_contratante, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_penalty).
legal_relation_instance(clausula_decima_terceira_obrigações_contratante, right_to_action, ortec_participacoes_empresariais_ltda, receive_payments).
legal_relation_instance(clausula_decima_quarta_cessão_contrato_credito_sucessão_subcontratação, duty_to_omit, ortec_participacoes_empresariais_ltda, omit_contract_cession).
legal_relation_instance(clausula_decima_quarta_cessão_contrato_credito_sucessão_subcontratação, no_right_to_action, ortec_participacoes_empresariais_ltda, contract_cession).
legal_relation_instance(clausula_decima_quarta_cessão_contrato_credito_sucessão_subcontratação, duty_to_omit, ortec_participacoes_empresariais_ltda, omit_issue_credit_title).
legal_relation_instance(clausula_decima_quarta_cessão_contrato_credito_sucessão_subcontratação, no_right_to_action, ortec_participacoes_empresariais_ltda, issue_credit_title).
legal_relation_instance(clausula_decima_quarta_cessão_contrato_credito_sucessão_subcontratação, duty_to_omit, ortec_participacoes_empresariais_ltda, omit_subcontracting).
legal_relation_instance(clausula_decima_quarta_cessão_contrato_credito_sucessão_subcontratação, no_right_to_action, ortec_participacoes_empresariais_ltda, subcontracting).
legal_relation_instance(clausula_decima_quarta_cessão_contrato_credito_sucessão_subcontratação, permission_to_act, ortec_participacoes_empresariais_ltda, corporate_restructuring).
legal_relation_instance(clausula_decima_quarta_cessão_contrato_credito_sucessão_subcontratação, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, analyze_risks_prejudice).
legal_relation_instance(clausula_decima_quarta_cessão_contrato_credito_sucessão_subcontratação, duty_to_act, ortec_participacoes_empresariais_ltda, maintain_contract_conditions).
legal_relation_instance(clausula_decima_quarta_cessão_contrato_credito_sucessão_subcontratação, subjection, ortec_participacoes_empresariais_ltda, aquiescence_bndes).
legal_relation_instance(clausula_decima_quinta_penalidades, duty_to_act, ortec_participacoes_empresariais_ltda, comply_with_contract).
legal_relation_instance(clausula_decima_quinta_penalidades, subjection, ortec_participacoes_empresariais_ltda, be_subject_to_penalties).
legal_relation_instance(clausula_decima_quinta_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_penalties).
legal_relation_instance(clausula_decima_quinta_penalidades, disability, ortec_participacoes_empresariais_ltda, avoid_participation_in_bndes_licitations).
legal_relation_instance(clausula_decima_quinta_penalidades, duty_to_act, ortec_participacoes_empresariais_ltda, refrain_from_tax_fraud).
legal_relation_instance(clausula_decima_quinta_penalidades, duty_to_act, ortec_participacoes_empresariais_ltda, refrain_from_frustrating_bidding).
legal_relation_instance(clausula_decima_sexta_alterações_contratuais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, respond_to_damages_from_refusal).
legal_relation_instance(clausula_decima_sexta_alterações_contratuais, subjection, banco_nacional_de_desenvolvimento_economico_e_social_bndes, be_liable_for_refusal_damages).
legal_relation_instance(clausula_decima_sexta_alterações_contratuais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, formalize_contract_alteration).
legal_relation_instance(clausula_decima_sexta_alterações_contratuais, no_right_to_omission, banco_nacional_de_desenvolvimento_economico_e_social_bndes, omit_formalization_of_contract_alteration).
legal_relation_instance(clausula_decima_sexta_alterações_contratuais, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, alter_contract).
legal_relation_instance(clausula_decima_setima_extinção_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, suspend_contract_execution).
legal_relation_instance(clausula_decima_setima_extinção_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, notify_of_breach).
legal_relation_instance(clausula_decima_setima_extinção_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_written_notice).
legal_relation_instance(clausula_decima_setima_extinção_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract_upon_breach).
legal_relation_instance(clausula_decima_setima_extinção_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, defend_against_termination).
legal_relation_instance(clausula_decima_setima_extinção_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract).
legal_relation_instance(clausula_decima_oitava_disposições_finais, permission_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, exercise_rights).
legal_relation_instance(clausula_decima_oitava_disposições_finais, no_right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, demand_strict_compliance).
legal_relation_instance(clausula_decima_nona_foro, subjection, banco_nacional_de_desenvolvimento_economico_e_social_bndes, submit_to_rio_de_janeiro_court).
legal_relation_instance(clausula_decima_nona_foro, no_right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, take_action_in_another_forum).
legal_relation_instance(clausula_nona_matriz_riscos, duty_to_omit, ortec_participacoes_empresariais_ltda, not_use_additives_allocated_events).
legal_relation_instance(clausula_nona_matriz_riscos, duty_to_act, ortec_participacoes_empresariais_ltda, respect_economic_financial_equilibrium_clause).
legal_relation_instance(clausula_nona_matriz_riscos, no_right_to_action, ortec_participacoes_empresariais_ltda, claim_additives_for_allocated_risks).

% --- Action catalog (local to this contract grounding) ---
action_type(accept_price_reduction).
action_label(accept_price_reduction, 'Accept price reduction').
action_type(adopt_sustainable_practices).
action_label(adopt_sustainable_practices, 'Adopt sustainable practices').
action_type(alter_contract).
action_label(alter_contract, 'Alter contract').
action_type(alter_contract_manager).
action_label(alter_contract_manager, 'Alter contract manager').
action_type(analyze_readjustment_request).
action_label(analyze_readjustment_request, 'Analyze readjustment request').
action_type(analyze_risks_prejudice).
action_label(analyze_risks_prejudice, 'Analyze risks/prejudice').
action_type(apply_penalties).
action_label(apply_penalties, 'Apply penalties').
action_type(apply_price_reduction_index).
action_label(apply_price_reduction_index, 'Apply price reduction index').
action_type(apresentar_documento_fiscal).
action_label(apresentar_documento_fiscal, 'Present fiscal document').
action_type(aquiescence_bndes).
action_label(aquiescence_bndes, 'Subject to BNDES aquiescence').
action_type(avoid_participation_in_bndes_licitations).
action_label(avoid_participation_in_bndes_licitations, 'Avoid BNDES licitations').
action_type(be_liable_for_refusal_damages).
action_label(be_liable_for_refusal_damages, 'Be liable for refusal damages').
action_type(be_subject_to_penalties).
action_label(be_subject_to_penalties, 'Be subject to penalties').
action_type(be_subject_to_price_reduction_index).
action_label(be_subject_to_price_reduction_index, 'Subject to price reduction').
action_type(claim_additives_for_allocated_risks).
action_label(claim_additives_for_allocated_risks, 'No right to claim additives').
action_type(communicate_administrative_procedure).
action_label(communicate_administrative_procedure, 'Communicate administrative procedure').
action_type(communicate_instructions).
action_label(communicate_instructions, 'Communicate instructions').
action_type(communicate_penalty).
action_label(communicate_penalty, 'Communicate penalties').
action_type(communicate_to_bndes).
action_label(communicate_to_bndes, 'Communicate to BNDES').
action_type(complement_quantities).
action_label(complement_quantities, 'Complement quantities').
action_type(comply_with_contract).
action_label(comply_with_contract, 'Comply with contract').
action_type(contract_cession).
action_label(contract_cession, 'No right to assign contract').
action_type(corporate_restructuring).
action_label(corporate_restructuring, 'Corporate restructuring').
action_type(defend_against_termination).
action_label(defend_against_termination, 'Right to defend against termination').
action_type(demand_services_executed_according_to_standards).
action_label(demand_services_executed_according_to_standards, 'Demand services be to standard').
action_type(demand_strict_compliance).
action_label(demand_strict_compliance, 'Demand strict compliance').
action_type(designate_contract_manager).
action_label(designate_contract_manager, 'Designate contract manager').
action_type(designate_contract_manager_substitute).
action_label(designate_contract_manager_substitute, 'Designate contract manager substitute').
action_type(designate_representative).
action_label(designate_representative, 'Designate representative').
action_type(effectuar_pagamento).
action_label(effectuar_pagamento, 'Effect payment').
action_type(emitir_documento_fiscal_em_conformidade_com_legislacao).
action_label(emitir_documento_fiscal_em_conformidade_com_legislacao, 'Issue compliant invoice').
action_type(encaminhar_documento_fiscal_por_email).
action_label(encaminhar_documento_fiscal_por_email, 'Send invoice via email').
action_type(enforce_contract_for_60_months).
action_label(enforce_contract_for_60_months, 'Enforce contract terms').
action_type(execute_contract_object).
action_label(execute_contract_object, 'Execute contract object').
action_type(execute_services_according_to_standards).
action_label(execute_services_according_to_standards, 'Execute services to standards').
action_type(exercise_rights).
action_label(exercise_rights, 'Exercise rights at any time').
action_type(exigir_comprovacao_regularidade).
action_label(exigir_comprovacao_regularidade, 'Require proof of tax regularity').
action_type(expect_execution_according_specifications).
action_label(expect_execution_according_specifications, 'Expect execution according to specs').
action_type(formalize_contract_alteration).
action_label(formalize_contract_alteration, 'Formalize contract alteration').
action_type(guarantee_no_infringement).
action_label(guarantee_no_infringement, 'Guarantee no infringement').
action_type(issue_credit_title).
action_label(issue_credit_title, 'No right to issue credit title').
action_type(maintain_conditions).
action_label(maintain_conditions, 'Maintain qualification conditions').
action_type(maintain_confidentiality).
action_label(maintain_confidentiality, 'Maintain confidentiality').
action_type(maintain_contract_conditions).
action_label(maintain_contract_conditions, 'Maintain contract conditions').
action_type(maintain_contract_for_60_months).
action_label(maintain_contract_for_60_months, 'Maintain contract').
action_type(make_payments_to_contracted_party).
action_label(make_payments_to_contracted_party, 'Make payments').
action_type(not_use_additives_allocated_events).
action_label(not_use_additives_allocated_events, 'Not use additives for allocated events').
action_type(notify_of_breach).
action_label(notify_of_breach, 'Notify of breach').
action_type(obey_instructions).
action_label(obey_instructions, 'Obey instructions').
action_type(observe_bndes_code_of_ethics).
action_label(observe_bndes_code_of_ethics, 'Observe BNDES ethics').
action_type(omit_allocate_bndes_employee_family).
action_label(omit_allocate_bndes_employee_family, 'Omit allocating BNDES employee family').
action_type(omit_contract_cession).
action_label(omit_contract_cession, 'Omit contract assignment').
action_type(omit_favoring_bndes_employees).
action_label(omit_favoring_bndes_employees, 'Omit favoring BNDES employees').
action_type(omit_formalization_of_contract_alteration).
action_label(omit_formalization_of_contract_alteration, 'Omit formalization of contract alteration').
action_type(omit_issue_credit_title).
action_label(omit_issue_credit_title, 'Omit issue credit title').
action_type(omit_subcontracting).
action_label(omit_subcontracting, 'Omit subcontracting').
action_type(omit_undue_advantage).
action_label(omit_undue_advantage, 'Omit undue advantage').
action_type(orient_professionals_about_confidentiality).
action_label(orient_professionals_about_confidentiality, 'Orient professionals').
action_type(pagar_juros_de_mora).
action_label(pagar_juros_de_mora, 'Pay late payment interest').
action_type(partially_execute_receive).
action_label(partially_execute_receive, 'Partially execute/receive object').
action_type(pay).
action_label(pay, 'Pay for executed object').
action_type(pay_taxes).
action_label(pay_taxes, 'Pay taxes').
action_type(permit_access_banco_central).
action_label(permit_access_banco_central, 'Permit access to Banco Central').
action_type(permit_inspections).
action_label(permit_inspections, 'Permit inspections').
action_type(power_to_receive_object).
action_label(power_to_receive_object, 'Power to receive object').
action_type(present_dif).
action_label(present_dif, 'Present DIF').
action_type(present_information_for_price_reduction).
action_label(present_information_for_price_reduction, 'Present information for price reduction').
action_type(present_supporting_documents_revision).
action_label(present_supporting_documents_revision, 'Present supporting documents for revision').
action_type(provide_code_of_ethics).
action_label(provide_code_of_ethics, 'Provide code of ethics').
action_type(provide_confidentiality_agreements).
action_label(provide_confidentiality_agreements, 'Provide confidentiality agreements').
action_type(provide_necessary_information).
action_label(provide_necessary_information, 'Provide necessary info').
action_type(provide_technical_support_and_software_update).
action_label(provide_technical_support_and_software_update, 'Provide technical support and software update').
action_type(provide_written_notice).
action_label(provide_written_notice, 'Provide written notice').
action_type(providenciar_exclusao).
action_label(providenciar_exclusao, 'Provide proof of exclusion from Simples Nacional').
action_type(receive_fiscal_document).
action_label(receive_fiscal_document, 'Receive fiscal document').
action_type(receive_object).
action_label(receive_object, 'Receive the object').
action_type(receive_payment).
action_label(receive_payment, 'Receive payment').
action_type(receive_payments).
action_label(receive_payments, 'Receive payments').
action_type(receive_technical_support_and_software_update).
action_label(receive_technical_support_and_software_update, 'Receive technical support and software update').
action_type(refrain_from_frustrating_bidding).
action_label(refrain_from_frustrating_bidding, 'Refrain from frustating bidding').
action_type(refrain_from_tax_fraud).
action_label(refrain_from_tax_fraud, 'Refrain from tax fraud').
action_type(remove_agents).
action_label(remove_agents, 'Remove Agents').
action_type(repair_damages).
action_label(repair_damages, 'Repair damages to BNDES').
action_type(repair_object).
action_label(repair_object, 'Repair the contract object').
action_type(request_confidentiality_agreements).
action_label(request_confidentiality_agreements, 'Request confidentiality agreements').
action_type(request_economic_financial_equilibrium).
action_label(request_economic_financial_equilibrium, 'Request economic-financial equilibrium').
action_type(request_price_adjustment_after_deadline).
action_label(request_price_adjustment_after_deadline, 'Request price adjustment after deadline').
action_type(request_price_adjustment_before_contract_end).
action_label(request_price_adjustment_before_contract_end, 'Request price adjustment before contract end').
action_type(request_price_readjustment).
action_label(request_price_readjustment, 'Request price readjustment').
action_type(request_price_revision).
action_label(request_price_revision, 'Request price revision').
action_type(respect_economic_financial_equilibrium_clause).
action_label(respect_economic_financial_equilibrium_clause, 'Respect economic equilibrium clause').
action_type(respond_to_damages_from_refusal).
action_label(respond_to_damages_from_refusal, 'Respond to damages from refusal').
action_type(right_to_receive_object).
action_label(right_to_receive_object, 'Right to receive object').
action_type(signing_confidentiality_agreements).
action_label(signing_confidentiality_agreements, 'Sign confidentiality agreements').
action_type(subcontracting).
action_label(subcontracting, 'No right to subcontract').
action_type(submit_to_rio_de_janeiro_court).
action_label(submit_to_rio_de_janeiro_court, 'Submit to Rio de Janeiro court').
action_type(suspend_analysis_readjustment_request).
action_label(suspend_analysis_readjustment_request, 'Suspend analysis of readjustment request').
action_type(suspend_contract_execution).
action_label(suspend_contract_execution, 'Suspend contract execution').
action_type(take_action_in_another_forum).
action_label(take_action_in_another_forum, 'No action in other forum').
action_type(take_measures_to_prevent_corruption).
action_label(take_measures_to_prevent_corruption, 'Prevent corruption').
action_type(terminate_contract).
action_label(terminate_contract, 'Terminate contract').
action_type(terminate_contract_upon_breach).
action_label(terminate_contract_upon_breach, 'Terminate contract for breach').

% ===== 3) Original Contract ABox =====
contract(contrato_ocs_050_2021).
contract_metadata(contrato_ocs_050_2021, numero_ocs, '50/2021').
contract_metadata(contrato_ocs_050_2021, numero_sap, '4400004568').
contract_metadata(contrato_ocs_050_2021, tipo_contrato, 'CONTRATO DE PRESTAÇÃO DE SERVIÇOS').
contract_metadata(contrato_ocs_050_2021, partes, ['BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES', 'ORTEC PARTICIPAÇÕES EMPRESARIAIS LTDA.']).
contract_metadata(contrato_ocs_050_2021, contratante, 'BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES').
contract_metadata(contrato_ocs_050_2021, contratado, 'ORTEC PARTICIPAÇÕES EMPRESARIAIS LTDA.').
contract_metadata(contrato_ocs_050_2021, cnpj_contratante, '33.657.248/0001-89').
contract_metadata(contrato_ocs_050_2021, cnpj_contratado, '32.287.634-0001-63').
contract_metadata(contrato_ocs_050_2021, procedimento_licitatorio, 'Dispensa de Licitação nº 28/2021').
contract_metadata(contrato_ocs_050_2021, data_autorizacao, '23/03/2021').
contract_metadata(contrato_ocs_050_2021, ip_ati_degat, '01/2021').
contract_metadata(contrato_ocs_050_2021, data_ip_ati_degat, '24/02/2021').
contract_metadata(contrato_ocs_050_2021, rubrica_orcamentaria, '3101700021').
contract_metadata(contrato_ocs_050_2021, centro_custo, 'BN00004000').
contract_metadata(contrato_ocs_050_2021, lei_aplicavel, 'Lei nº 13.303/2016').
contract_metadata(contrato_ocs_050_2021, regulamento, 'Regulamento de Formalização, Execução e Fiscalização dos Contratos Administrativos do Sistema BNDES').
contract_clause(contrato_ocs_050_2021, clausula_primeira_objeto, 'CLÁUSULA PRIMEIRA – OBJETO', 'O presente Contrato tem por objeto a prestação de serviço de suporte técnico e atualização de software IBM Sterling ConnectDirect, conforme especificações constantes do Termo de Referência e da Proposta apresentada pela CONTRATADA, respectivamente, Anexos I e II deste Contrato.').
contract_clause(contrato_ocs_050_2021, clausula_segunda_vigencia, 'CLÁUSULA SEGUNDA – VIGÊNCIA', 'O presente Contrato terá duração de 60 (sessenta) meses, a contar da data de sua assinatura.').
contract_clause(contrato_ocs_050_2021, clausula_terceira_local_prazo_condicoes_execucao_objeto, 'CLÁUSULA TERCEIRA – LOCAL, PRAZO E CONDIÇÕES DE EXECUÇÃO DO OBJETO', 'A execução do objeto contratado respeitará as especificações constantes das Especificações Técnicas e da proposta apresentada pelo CONTRATADO, respectivamente, Anexos I e II deste Contrato.').
contract_clause(contrato_ocs_050_2021, clausula_quarta_niveis_servico, 'CLÁUSULA QUARTA – NÍVEIS DE SERVIÇO', 'Os serviços contratados deverão ser executados de acordo com os padrões de qualidade, disponibilidade e desempenho estipulados pelo BNDES, observados os níveis de serviço descritos no Anexo I (Especificações Técnicas) deste Contrato. Parágrafo Único O descumprimento dos níveis de serviço acarretará a aplicação dos índices de redução do preço previstos no Anexo I (Especificações Técnicas) deste Contrato, sem prejuízo da aplicação das penalidades previstas neste Contrato, quando cabíveis.').
contract_clause(contrato_ocs_050_2021, clausula_quinta_recebimento_objeto, 'CLÁUSULA QUINTA – RECEBIMENTO DO OBJETO', 'O BNDES efetuará o recebimento do objeto, através do Gestor, mencionado na Cláusula de Obrigações do BNDES deste Contrato, observado o disposto no Anexo I (Especificações Técnicas) deste Contrato.').
contract_clause(contrato_ocs_050_2021, clausula_sexta_preco, 'CLÁUSULA SEXTA – PREÇO', 'O BNDES pagará ao CONTRATADO, pela execução do objeto contratado, o valor de até R$ 44.907,00 (quarenta e quatro mil, novecentos e sete reais), conforme proposta apresentada (Anexo II deste Contrato), observado o disposto na Cláusula de Pagamento deste Instrumento. Parágrafo Primeiro No valor ajustado no caput desta Cláusula estão incluídos todos os insumos, encargos trabalhistas e tributos, inclusive contribuições fiscais e parafiscais, bem como quaisquer outras despesas necessárias à execução deste Contrato. Parágrafo Segundo Na hipótese de o objeto ser, a critério do BNDES, parcialmente executado e recebido, os valores previstos nesta Cláusula serão proporcionalmente reduzidos, sem prejuízo da aplicação das penalidades cabíveis. Parágrafo Terceiro Caso o BNDES não demande o total do objeto previsto neste Contrato, não será devida indenização ao CONTRATADO. Parágrafo Quarto O CONTRATADO deverá arcar com os ônus decorrentes de eventual equívoco no dimensionamento dos quantitativos de sua proposta, devendo complementá-los, caso os quantitativos previstos inicialmente em sua proposta não sejam satisfatórios para o atendimento ao objeto deste Contrato.').
contract_clause(contrato_ocs_050_2021, clausula_setima_pagamento, 'CLÁUSULA SÉTIMA – PAGAMENTO', 'O BNDES efetuará o pagamento referente ao objeto deste Contrato, mensalmente, por meio de crédito em conta bancária, em até 10 (dez) dias úteis a contar da data de apresentação do documento fiscal ou equivalente legal (como nota fiscal, fatura, boleto bancário com código de barras, recibo de pagamento a autônomo), desde que tenha sido efetuado ateste pelo Gestor do Contrato das obrigações contratuais assumidas pelo CONTRATADO, observado o disposto no Anexo I (Especificações Técnicas) deste Instrumento. Parágrafo Primeiro O documento fiscal ou equivalente legal deverá ser apresentado ao BNDES no mês de sua emissão e até o dia 25 (vinte e cinco) do mesmo – ou data anterior que viabilize o tempestivo recolhimento de ISS, se a legislação tributária municipal incidente assim exigir – possibilitando o cumprimento, pelo BNDES, das obrigações fiscais principais e acessórias decorrentes deste Contrato. Havendo impedimento legal para o cumprimento desse prazo, o documento fiscal ou equivalente legal deverá ser apresentado até o primeiro dia útil do mês seguinte, mediante prévia autorização do BNDES. Parágrafo Segundo O primeiro documento fiscal ou equivalente legal terá como objeto de cobrança o período compreendido entre o dia de início da prestação dos serviços e o último dia desse mês, e os documentos fiscais ou equivalentes legais subsequentes terão como referência o período compreendido entre o primeiro e o último dia de cada mês. O último documento fiscal ou equivalente legal, por seu turno, referir-se-á ao período compreendido entre o primeiro dia do último mês da prestação dos serviços e o último dia de serviço prestado. Em todos os casos, o documento fiscal ou equivalente legal só poderá ser emitido e apresentado ao BNDES após a efetiva prestação do serviço, respeitado o disposto no Parágrafo anterior. Parágrafo Terceiro Para toda efetivação de pagamento, o CONTRATADO deverá encaminhar 1 (uma) via do documento fiscal ou equivalente legal à caixa de e-mail nfe@bndes.gov.br, ou, quando emitido em papel, ao Protocolo do Edifício de Serviços do BNDES no Rio de Janeiro - EDSERJ, localizado na Avenida República do Chile nº 100, Térreo, Centro, Rio de Janeiro, CEP nº 20.031-917, no período compreendido entre 10h e 18h. Parágrafo Quarto O documento fiscal ou equivalente legal deverá respeitar a legislação tributária e conter, minimamente, as seguintes informações: I. número da Ordem de Compra/Serviço – OCS; II. número SAP do Contrato; III. número do pedido SAP, a ser informado pelo Gestor do Contrato. IV. número da Folha de Registro de Serviços (FRS), a ser informado pelo Gestor do Contrato V. descrição detalhada do objeto executado e dos respectivos valores; VI. período de referência da execução do objeto; VII. nome e número do CONTRATADO, como o número de inscrição na Fazenda Municipal e/ou Estadual, conforme o caso; VIII. nome, telefone e e-mail do responsável pelo documento fiscal ou equivalente legal; IX. nome e número do banco e da agência, bem como o número da conta corrente do CONTRATADO, vinculada ao CNPJ constante do documento fiscal ou equivalente legal, com respectivos dígitos verificadores; X. tomador dos serviços: Banco Nacional de Desenvolvimento Econômico e Social – BNDES; XI. CNPJ do tomador dos serviços: escritório no Rio de Janeiro, CNPJ n° 33.657.248/0001-89, escritório em Brasília, CNPJ nº 33.657.248/0004-21; escritório no Recife, CNPJ nº 33.657.248/0006-93; escritório em São Paulo, CNPJ nº 33.657.248/0003-40; XII. local de execução do objeto, emitindo-se um documento fiscal ou equivalente legal para cada Município em que o serviço seja prestado, se for o caso; e XIII. código dos serviços, nos termos da lista anexa à Lei Complementar nº 116/2003, em concordância com as informações inseridas na Declaração de Informações para Fornecimento. Parágrafo Quinto O documento fiscal ou equivalente legal emitido pela CONTRATADA deverá estar em conformidade com a legislação do Município onde a CONTRATADA esteja estabelecida, cuja regularidade fiscal foi avaliada na etapa de habilitação, e com as normas regulamentares aprovadas pela Secretaria da Receita Federal do Brasil, especialmente no que tange à retenção de tributos federais, sob pena de devolução do documento e interrupção do prazo para pagamento. Parágrafo Sexto Caso a CONTRATADA emita documento fiscal ou equivalente legal autorizado por Município diferente daquele onde se localiza o estabelecimento do BNDES tomador do serviço e destinatário da cobrança, deverá providenciar o cadastro junto à Secretaria Municipal de Fazenda ou órgão equivalente do Município do estabelecimento tomador, salvo quando se aplicar uma das exceções constantes dos incisos do artigo 3º da Lei Complementar Federal nº 116/03. A inexistência desse cadastro ou o cadastro em item diverso do faturado não constitui impeditivo ao processo de pagamento, mas um ônus a ser suportado pela CONTRATADA, uma vez que o BNDES está obrigado a reter na fonte a quantia equivalente ao ISS dos serviços faturados, conforme legislação aplicável. Parágrafo Sétimo Ao documento fiscal ou equivalente legal deverão ser anexados: I. certidões de regularidade fiscal exigidas na fase de habilitação; II. comprovante de que o CONTRATADO é optante do Simples Nacional, se for o caso; III. em caso de isenção/imunidade tributária, documentos comprobatórios com a indicação do dispositivo legal que ampara a isenção/imunidade; e IV. demais documentos solicitados pelo Gestor do Contrato, necessários ao pagamento do objeto contratado. Parágrafo Oitavo Caso sejam verificadas divergências, o BNDES devolverá o documento fiscal ou equivalente legal ao CONTRATADO ou solicitará a emissão de carta de correção, quando cabível, interrompendo-se o prazo de pagamento até que este providencie as medidas saneadoras ou comprove a correção dos dados contestados pelo BNDES. Parágrafo Nono Os pagamentos a serem efetuados em favor do CONTRATADO estarão sujeitos, no que couber, às retenções de tributos, nos termos da legislação tributária e com base nas informações prestadas pelo CONTRATADO. Parágrafo Décimo Além de outras hipóteses previstas em lei ou no Contrato, o BNDES poderá descontar, do montante expresso no documento fiscal ou equivalente legal, os valores referentes a multas, indenizações apuradas em processo administrativo, bem como qualquer obrigação que decorra do descumprimento da legislação pelo CONTRATADO. Parágrafo Décimo Primeiro Caso o BNDES não efetue o pagamento na forma prevista nesta Cláusula, em decorrência de fato não atribuível ao CONTRATADO, aos valores devidos serão acrescidos juros de mora de 0,5% (meio por cento) ao mês, pro rata tempore, calculados desde o dia do vencimento até a data da efetiva liquidação.').
contract_clause(contrato_ocs_050_2021, clausula_oitava_equilibrio_economico_financeiro_contrato, 'CLÁUSULA OITAVA – EQUILÍBRIO ECONÔMICO-FINANCEIRO DO CONTRATO O BNDES e o CONTRATADO têm direito ao equilíbrio econômico-financeiro do Contrato, em consonância com o inciso XXI, do artigo 37, da Constituição Federal, a ser realizado mediante reajuste ou revisão de preços.  Parágrafo Primeiro O reajuste de preços, na forma prevista na legislação, poderá ser requerido pelo CONTRATADO a cada período mínimo de 12 (doze) meses, sendo o primeiro contado do dia 01/02/2021, data de apresentação da proposta (Anexo II deste Contrato).  Parágrafo Segundo A revisão de preços poderá ser realizada por iniciativa do BNDES ou mediante solicitação do CONTRATADO, quando ocorrer fato imprevisível ou previsível, porém, de consequências incalculáveis, retardador ou impeditivo da execução do Contrato, ou ainda em caso de força maior, caso fortuito ou fato do príncipe, configurando álea econômica extraordinária e extracontratual, que onere ou desonere as obrigações pactuadas no presente Instrumento, sendo, porém, vedada nas hipóteses em que o risco seja alocado ao CONTRATADO nos termos da Cláusula de Matriz de Riscos, respeitando-se o seguinte: I. o CONTRATADO deverá formular ao BNDES requerimento para a revisão do Contrato, comprovando a ocorrência do fato gerador; II. a comprovação será realizada por meio de documentos, tais como, atos normativos que criem ou alterem tributos, lista de preço de fabricantes, notas fiscais de aquisição de matérias-primas, de transporte de mercadorias, alusivas à época da elaboração da proposta ou do último reajuste e do momento do pedido de revisão; e III. com o requerimento, o CONTRATADO deverá apresentar planilhas de custos unitários, comparativas entre a data da formulação da proposta ou do último reajuste e o momento do pedido de revisão, contemplando os custos unitários envolvidos e evidenciando o quanto o aumento de preços ocorrido repercute no valor pactuado.  Parágrafo Terceiro Independentemente de solicitação, o BNDES poderá convocar o CONTRATADO para negociar a redução dos preços, mantendo o mesmo objeto contratado, na quantidade e nas especificações indicadas na proposta, em virtude da redução dos preços de mercado, ou de itens que compõem o custo, cabendo ao CONTRATADO apresentar as informações solicitadas pelo BNDES.   Parágrafo Quarto O CONTRATADO deverá solicitar o reajuste e/ou a revisão de preços até o encerramento do Contrato, hipótese em que os efeitos financeiros serão concedidos de modo retroativo a partir do fato gerador, observando-se, ainda, que: I. caso o fato gerador do reajuste e/ou da revisão de preços ou a divulgação do índice de reajuste ocorra com antecedência inferior a 60 (sessenta) dias do encerramento do Contrato, o CONTRATADO terá o prazo de 60 (sessenta) dias, a contar do fato gerador ou da data de divulgação do índice, para solicitar o reajuste e/ou a revisão de preços; II. caso a divulgação do índice de reajuste ocorra após o encerramento do Contrato, o CONTRATADO terá o prazo de 60 (sessenta) dias, a contar da data de divulgação do índice, para solicitar o reajuste de preços; III. o BNDES deverá analisar o pedido de reajuste e/ou revisão de preços em até 60 (sessenta) dias, contados da solicitação e da entrega pelo CONTRATADO dos comprovantes de variação dos custos, ficando este prazo suspenso, a critério do BNDES, enquanto o CONTRATADO não apresentar a documentação solicitada para a comprovação da variação de custos; e IV. caso o CONTRATADO não solicite o reajuste e/ou revisão de preços nos prazos fixados acima, operar-se-á a renúncia a eventual direito ao reajuste e/ou à revisão.', clausula_oitava_equilibrio_economico_financeiro_contrato).
contract_clause(contrato_ocs_050_2021, clausula_nona_matriz_riscos, 'CLÁUSULA NONA – MATRIZ DE RISCOS O BNDES e o CONTRATADO, tendo como premissa a obtenção do melhor custo contratual mediante a alocação do risco à parte com maior capacidade para geri-lo e absorvê-lo, identificam os riscos decorrentes da relação contratual e, sem prejuízo de outras previsões contratuais, estabelecem os respectivos responsáveis na Matriz de Riscos constante do Anexo III deste Contrato.   Parágrafo Primeiro O reajuste de preço aludido na Matriz de Riscos deve respeitar o disposto na
contract_clause(contrato_ocs_050_2021, clausula_decima_obrigações_contratado, 'CLÁUSULA DÉCIMA – OBRIGAÇÕES DO CONTRATADO Além de outras obrigações estabelecidas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do CONTRATADO: I. manter durante a vigência deste Contrato todas as condições de habilitação exigidas quando da contratação, comprovando-as sempre que solicitado pelo BNDES; II. comunicar a imposição, a si ou a qualquer consorciada, de penalidade que acarrete o impedimento de contratar com o BNDES, bem como a eventual perda dos pressupostos para a licitação; III. reparar, corrigir, remover, reconstruir ou substituir, às suas expensas, no total ou em parte, o objeto do Contrato em que se verificarem vícios, defeitos ou incorreções decorrentes da execução; IV. reparar todos os danos e prejuízos causados ao BNDES ou a terceiros, não restando excluída ou reduzida esta responsabilidade pela presença de fiscalização ou pelo acompanhamento da execução por parte do Gestor do Contrato; V. pagar todos os encargos e tributos, que incidam ou venham a incidir, direta ou indiretamente, sobre o objeto deste Contrato, podendo o BNDES, a qualquer momento, exigir do CONTRATADO a comprovação de sua regularidade; VI. providenciar, perante a Receita Federal do Brasil - RFB, comprovando ao BNDES, sua exclusão obrigatória do Simples Nacional, no prazo estipulado pelo artigo 30 da Lei Complementar nº 123/2006, se o CONTRATADO, quando optante: a) extrapolar o limite de receita bruta anual previsto no artigo 3º da Lei Complementar nº 123/2006, ao longo da vigência deste Contrato; ou b) enquadrar-se em alguma das situações previstas no artigo 17 da Lei Complementar nº 123/2006; VII. permitir vistorias e acompanhamento da execução do objeto pelo Gestor do Contrato; VIII. obedecer às instruções e aos procedimentos, estabelecidos pelo BNDES, para a adequada execução do Contrato; IX. designar 01 (um) preposto como responsável pelo Contrato firmado com o BNDES, para participar de eventuais reuniões e ser o interlocutor do CONTRATADO, zelando pelo fiel cumprimento das obrigações previstas neste Instrumento; X. permitir ao Banco Central do Brasil acesso a termos firmados, documentos e informações atinentes aos serviços prestados, bem como às suas dependências, nos termos do § 1º do artigo 33 da Resolução CMN nº 4.557/2017; XI. apresentar, em até 10 dias úteis após a convocação, a Declaração de Informações para Fornecimento - DIF, adequadamente preenchida, sob pena de instauração de procedimento punitivo para aplicação de penalidade, e de retenção tributária, pelo BNDES, nos casos previstos em lei, da alíquota que entender adequada; a) as informações inseridas na Declaração de Informações para Fornecimento – DIF não deverão divergir das constantes do documento fiscal ou equivalente legal; XII.  garantir que o objeto do Contrato não infringe quaisquer direitos autorais, patentes ou registros, inclusive marcas, know-how ou trade-secrets, sendo responsável pelos prejuízos, inclusive honorários de advogado, custas e despesas decorrentes de qualquer medida ou processo judicial ou administrativo iniciado em face do BNDES, por acusação da espécie, podendo o CONTRATADO ser instado a intervir no processo;', clausula_decima_obrigações_contratado).
contract_clause(contrato_ocs_050_2021, clausula_decima_primeira_conduta_ética_do_contratado_e_do_bndes, 'CLÁUSULA DÉCIMA PRIMEIRA – CONDUTA ÉTICA DO CONTRATADO E DO BNDES O CONTRATADO e o BNDES comprometem-se a manter a integridade nas relações público-privadas, agindo de boa-fé e de acordo com os princípios da moralidade administrativa e da impessoalidade, além de pautar sua conduta por preceitos éticos e, em especial, por sua responsabilidade socioambiental.  Parágrafo Primeiro Em atendimento ao disposto no caput desta Cláusula, o CONTRATADO obriga-se, inclusive, a: I. não oferecer, prometer, dar, autorizar, solicitar ou aceitar, direta ou indiretamente, qualquer vantagem indevida, seja pecuniária ou de outra natureza, consistente em fraude, ato de corrupção ou qualquer outra violação de dever legal, relacionada com este Contrato, bem como a tomar todas as medidas ao seu alcance para impedir administradores, empregados, agentes, representantes, fornecedores, contratados ou subcontratados, seus ou de suas controladas, de fazê-lo; II. impedir o favorecimento ou a participação de empregado ou dirigente do Sistema BNDES (BNDES e suas subsidiárias) na execução do objeto do presente Contrato; III. providenciar para que não sejam alocados, na execução dos serviços, familiares de dirigente ou empregado do Sistema BNDES, considerando-se familiar o cônjuge, o companheiro ou o parente em linha reta ou colateral, por consanguinidade ou afinidade, até o terceiro grau; IV. observar o Código de Ética do Sistema BNDES vigente ao tempo da contratação, bem como a Política de Conduta e de Integridade das Licitações e Contratos Administrativos do Sistema BNDES e a Política Corporativa Anticorrupção do Sistema BNDES, assegurando-se de que seus representantes, administradores e todos os profissionais envolvidos na execução do objeto pautem seu comportamento e sua atuação pelos princípios neles constantes; e V. adotar, na execução dos serviços, boas práticas de sustentabilidade ambiental, de otimização de recursos, de redução de desperdícios e de redução da poluição.  Parágrafo Segundo O BNDES recomenda, ao CONTRATADO, considerar em suas práticas de gestão a implantação de programa de integridade estruturado, voltado à prevenção, detecção e remediação da ocorrência de fraudes e atos de corrupção.  Parágrafo Terceiro Verificada uma das situações mencionadas nos incisos II e III do Parágrafo Primeiro desta Cláusula, compete ao CONTRATADO afastar imediatamente da execução do Contrato os agentes que impliquem a ocorrência dos impedimentos e favorecimentos aludidos, além de comunicar tal fato ao BNDES, sem prejuízo de apuração de sua responsabilidade, caso tenha agido de má-fé.  Parágrafo Quarto O CONTRATADO declara ter conhecimento do Código de Ética do Sistema BNDES, bem como da Política de Conduta e de Integridade das Licitações e Contratos Administrativos do Sistema BNDES e da Política Corporativa Anticorrupção do Sistema BNDES, que poderão ser consultados por intermédio do sítio eletrônico www.bndes.gov.br ou requisitados ao Gestor do Contrato.  Parágrafo Quinto Eventuais irregularidades ou descumprimentos das normas internas do BNDES ou da legislação vigente podem ser denunciados à Ouvidoria por qualquer cidadão através dos seguintes canais: página na internet (www.bndes.gov.br/ouvidoria); correio (Caixa Postal 15054, CEP 20031-120, Rio de Janeiro – RJ); e telefone (0800 702 6307).', clausula_decima_primeira_conduta_ética_do_contratado_e_do_bndes).
contract_clause(contrato_ocs_050_2021, clausula_decima_segunda_sigilo_das_informações, 'CLÁUSULA DÉCIMA SEGUNDA – SIGILO DAS INFORMAÇÕES Caso o CONTRATADO venha a ter acesso a dados, materiais, documentos e informações de natureza sigilosa, direta ou indiretamente, em decorrência da execução do objeto contratual, deverá manter o sigilo dos mesmos, bem como orientar os profissionais envolvidos a cumprir esta obrigação, respeitando-se as diretrizes e normas da Política Corporativa de Segurança da Informação do BNDES.  Parágrafo Único Assim que solicitado pelo Gestor do Contrato, o CONTRATADO deverá providenciar a assinatura, por seu representante legal e pelos profissionais que tiverem acesso a informações sigilosas, dos Termos de Confidencialidade a serem disponibilizados pelo BNDES.', clausula_decima_segunda_sigilo_das_informações).
contract_clause(contrato_ocs_050_2021, clausula_decima_terceira_obrigações_contratante, 'CLÁUSULA DÉCIMA TERCEIRA – OBRIGAÇÕES DO BNDES', 'Além de outras obrigações estipuladas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do BNDES: I. realizar os pagamentos devidos ao CONTRATADO, nas condições estabelecidas neste Contrato; II. designar, como Gestor do Contrato, Frederico Henrique Bohm Argolo, que atualmente exerce a função de Coordenador de Serviços , a quem caberá o acompanhamento, a fiscalização e a avaliação da execução dos serviços, bem como a liquidação da despesa e o atestado de cumprimento das obrigações assumidas; III. designar, o substituto do Gestor do Contrato, para atuar em sua eventual ausência;  IV. alterar, quando conveniente, o Gestor do Contrato e/ou o seu substituto, por outro profissional, mediante comunicação escrita ao CONTRATADO; V. fornecer ao CONTRATADO, quando solicitado ao Gestor do Contrato, cópia do Código de Ética do Sistema BNDES, da Política de Conduta e de Integridade das Licitações e Contratos Administrativos do Sistema BNDES, da Política Corporativa Anticorrupção do Sistema BNDES e da Política Corporativa de Segurança da Informação do BNDES; VI. colocar à disposição do CONTRATADO todas as informações necessárias à perfeita execução dos serviços objeto deste Contrato; e VII. comunicar ao CONTRATADO, por escrito:  a) quaisquer instruções ou procedimentos sobre assuntos relacionados ao Contrato; b) a abertura de procedimento administrativo para a apuração de condutas irregulares do CONTRATADO, concedendo-lhe prazo para defesa; e c) a aplicação de eventual penalidade, nos termos deste Contrato.').
contract_clause(contrato_ocs_050_2021, clausula_decima_quarta_cessão_contrato_credito_sucessão_subcontratação, 'CLÁUSULA DÉCIMA QUARTA – CESSÃO DE CONTRATO OU DE CRÉDITO, SUCESSÃO CONTRATUAL E SUBCONTRATAÇÃO', 'É vedada a cessão deste Contrato, total ou parcialmente, ou de qualquer crédito dele decorrente, bem como a emissão, por parte do CONTRATADO, de qualquer título de crédito em razão do mesmo.  Parágrafo Primeiro É admitida a sucessão contratual nas hipóteses em que o CONTRATADO realizar as operações societárias de fusão, cisão ou incorporação, condicionada aos seguintes requisitos: I. aquiescência prévia do BNDES, que analisará eventuais riscos ou prejuízos decorrentes de tal alteração contratual; e II. manutenção de todas as condições contratuais e requisitos de habilitação originais.  Parágrafo Segundo Caso ocorra a sucessão contratual admitida no Parágrafo anterior, o sucessor assumirá integralmente a posição do sucedido, passando a ser responsável pela execução do presente Contrato, fazendo jus, por conseguinte, ao recebimento dos créditos dele decorrentes.  Parágrafo Terceiro É vedada a subcontratação para a execução do objeto deste Contrato.').
contract_clause(contrato_ocs_050_2021, clausula_decima_quinta_penalidades, 'CLÁUSULA DÉCIMA QUINTA – PENALIDADES', 'Em caso de inexecução total ou parcial do Contrato, inclusive de descumprimento de exigência expressamente formulada pelo BNDES ou de inobservância de qualquer obrigação legal, bem como em caso de mora, sem motivo justificado, o CONTRATADO ficará sujeito às seguintes penalidades: I. advertência; II. multa de até: a) na hipótese da Contratada deixar de garantir o nível mínimo de serviço previsto na tabela do item 3.9 das Especificações Técnicas e sendo ultrapassado o limite de ajuste de pagamento estabelecido no item 8.6 das Especificações Técnicas, será aplicada multa sobre o valor da respectiva fatura mensal, referente ao serviço de suporte técnico e atualização no Contrato, de até 0,07% (sete centésimos por cento) por hora excedente, de acordo com a severidade do chamado; b) de até 10% (dez por cento), apurada de acordo com a gravidade da infração, incidindo sobre o valor global do Contrato, em razão do descumprimento de outras obrigações contratuais não abrangidas no item 9.1.2 das Especificações Técnicas; e III. suspensão temporária de participação em licitação e impedimento de contratar com o BNDES, por prazo não superior a 2 (dois) anos, apurado de acordo com a gravidade da infração.  Parágrafo Primeiro As penalidades indicadas nesta Cláusula somente poderão ser aplicadas após procedimento administrativo, e desde que assegurados o contraditório e a ampla defesa, facultada ao CONTRATADO a defesa prévia, no prazo de 10 (dez) dias úteis.  Parágrafo Segundo  Contra a decisão de aplicação de penalidade, o CONTRATADO poderá interpor o recurso cabível, na forma e no prazo previstos no Regulamento de Formalização, Execução e Fiscalização de Contratos Administrativos do Sistema BNDES.  Parágrafo Terceiro  A imposição de penalidade prevista nesta Cláusula não impede a extinção do Contrato pelo BNDES, nos termos da legislação aplicável e da Cláusula de Extinção do Contrato.   Parágrafo Quarto  A multa prevista nesta Cláusula poderá ser aplicada juntamente com as demais penalidades.  Parágrafo Quinto  A multa aplicada ao CONTRATADO e os prejuízos causados ao BNDES serão deduzidos de quaisquer créditos a ele devidos, ressalvada a possibilidade de cobrança judicial da diferença eventualmente não coberta pelos mencionados créditos.  Parágrafo Sexto  No caso de uso indevido de informações sigilosas, observar-se-ão, no que couber, os termos da Lei nº 12.527/2011 e do Decreto nº 7.724/2012.  Parágrafo Sétimo  No caso de atos lesivos à Administração Pública, nacional ou estrangeira, observar-se-ão os termos da Lei nº 12.846/2013.  Parágrafo Oitavo A sanção prevista no inciso III desta Cláusula também poderá ser aplicada às sociedades ou profissionais que: I. tenham sofrido condenação definitiva por praticarem, por meios dolosos, fraude fiscal no recolhimento de quaisquer tributos; II. tenham praticado atos ilícitos visando frustrar os objetivos da licitação; III. demonstrem não possuir idoneidade para contratar com o BNDES em virtude de atos ilícitos praticados.').
contract_clause(contrato_ocs_050_2021, clausula_decima_sexta_alterações_contratuais, 'CLÁUSULA DÉCIMA SEXTA – ALTERAÇÕES CONTRATUAIS', 'O presente Contrato poderá ser alterado, por acordo entre as partes, nas hipóteses disciplinadas no art. 81 da Lei nº 13.303/2016, entre outras legal ou contratualmente previstas, observando-se que:  I. as alterações devem preservar o equilíbrio econômico-financeiro do Contrato; e II. é vedada a modificação contratual que desnature o objeto da contratação ou afete as condições essenciais previstas no Especificações Técnicas (Anexo I deste Contrato).   Parágrafo Primeiro Em atenção aos princípios que regem as relações contratuais, nas hipóteses em que for imprescindível a alteração deste Contrato para viabilizar sua plena execução, conforme demonstrado em processo administrativo, não caberá a recusa das partes à respectiva formalização, salvo em caso de justo motivo, devidamente comprovado pela parte que o alegar.  Parágrafo Segundo       A parte que, injustificadamente, se recusar a promover a alteração contratual indicada no Parágrafo anterior, deverá responder pelos danos eventualmente causados, sem prejuízo das demais consequências previstas neste Instrumento e na legislação vigente.     Parágrafo Terceiro As alterações contratuais serão formalizadas mediante instrumento aditivo, ressalvadas as hipóteses legais que admitem a alteração por apostilamento e os pequenos ajustes necessários à eventual correção de erros materiais ou à alteração de dados acessórios do Contrato, que poderão ser celebrados por meio epistolar.').
contract_clause(contrato_ocs_050_2021, clausula_decima_setima_extinção_contrato, 'CLÁUSULA DÉCIMA SÉTIMA – EXTINÇÃO DO CONTRATO', 'O presente Contrato poderá ser extinto de acordo com as hipóteses previstas na legislação, convencionando-se, ainda, que é cabível a sua resolução: I. em razão do inadimplemento total ou parcial de qualquer de suas obrigações, cabendo à parte inocente notificar a outra por escrito, assinalando-lhe prazo razoável para o cumprimento das obrigações, quando o mesmo não for previamente fixado neste instrumento ou em seus anexos; II. na ausência de liberação, por parte do BNDES, de área, local ou objeto necessário para a sua execução, nos prazos contratuais; III. em virtude da suspensão da execução do Contrato, por ordem escrita do BNDES, por prazo superior a 120 (cento e vinte) dias ou ainda por repetidas suspensões que totalizem o mesmo prazo;  IV. quando for decretada a falência do CONTRATADO; V. caso o CONTRATADO perca uma das condições de habilitação exigidas quando da contratação; VI. na hipótese de descumprimento do previsto na Cláusula de Cessão de Contrato ou de Crédito, Sucessão Contratual e Subcontratação; VII. caso o CONTRATADO seja declarada inidônea pela União, por Estado ou pelo Distrito Federal;  VIII. em função da suspensão do direito de o CONTRATADO licitar ou contratar com o BNDES; IX. na hipótese de caracterização de ato lesivo à Administração Pública, nos termos da Lei nº 12.846/2013, cometido pelo CONTRATADO no processo de contratação ou por ocasião da execução contratual; X. em razão da dissolução do CONTRATADO;  XI. quando da ocorrência de caso fortuito ou de força maior, regularmente comprovado, impeditivo da execução do Contrato.  Parágrafo Primeiro Caracteriza inadimplemento das obrigações de pagamento pecuniário do presente Contrato, a mora superior a 90 (noventa) dias.  Parágrafo Segundo Os casos de extinção contratual convencionados no caput desta Cláusula deverão ser precedidos de notificação escrita à outra parte do Contrato, e de oportunidade de defesa, dispensada a necessidade de interpelação judicial.').
contract_clause(contrato_ocs_050_2021, clausula_decima_oitava_disposições_finais, 'CLÁUSULA DÉCIMA OITAVA – DISPOSIÇÕES FINAIS', 'Este Contrato representa todo o acordo entre as partes com relação ao objeto nele previsto.   Parágrafo Primeiro Integram o presente Contrato: Anexo I - Especificações Técnicas - BNDES Anexo II - Proposta Anexo III - Matriz de Risco  Parágrafo Segundo A omissão ou tolerância quanto à exigência do estrito cumprimento das obrigações contratuais ou ao exercício de prerrogativa decorrente deste Contrato não constituirá renúncia ou novação nem impedirá as partes de exercerem os seus direitos a qualquer tempo.').
contract_clause(contrato_ocs_050_2021, clausula_decima_nona_foro, 'CLÁUSULA DÉCIMA NONA – FORO', 'É competente o foro da cidade do Rio de Janeiro para solucionar eventuais litígios decorrentes deste Contrato, afastado qualquer outro, por mais privilegiado que seja.  As folhas deste Contrato são conferidas por Ana Paula Soeiro de Britto, advogada do BNDES, apenas para conferência de sua redação, por autorização do representante legal que o assina.  E, por estarem assim justos e contratados, firmam o presente Instrumento, redigido em 1 (uma) via, juntamente com as testemunhas abaixo.  Reputa-se celebrado o presente Contrato na data em que for registrada a última assinatura dos representantes legais do BNDES.      _____________________________________________________________________ BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES    _____________________________________________________________________ ORTEC PARTICIPAÇÕES EMPRESARIAIS LTDA.   Testemunhas:   _________________________________ _________________________________ Nome/CPF: Nome/CPF:       ELIANE MARIA POLAK GRALAKI:02254358960Assinado de forma digital por ELIANE MARIA POLAK GRALAKI:02254358960 Dados: 2021.03.25 16:29:27 -03\'00\'RICARDO SLOMKA DE OLIVEIRA:16475948802Assinado de forma digital por RICARDO SLOMKA DE OLIVEIRA:16475948802 Dados: 2021.03.25 16:56:31 -03\'00\'MARCIO OLIVEIRA DA ROCHA:07635921703Assinado de forma digital por MARCIO OLIVEIRA DA ROCHA:07635921703 Dados: 2021.03.26 12:13:22 -03\'00\'LUCIANA GIULIANI DE OLIVEIRA REIS:81364199734Assinado de forma digital por LUCIANA GIULIANI DE OLIVEIRA REIS:81364199734 Dados: 2021.03.29 09:25:54 -03\'00\'FERNANDO PASSERI LAVRADO:00486757765Assinado de forma digital por FERNANDO PASSERI LAVRADO:00486757765 Dados: 2021.03.29 09:28:59 -03\'00\'').

% ===== END =====
